;;; tools/tree-sitter/config.el -*- lexical-binding: t; -*-
;;; Commentary:
;;
;; treesit is fairly new, so *-ts-mode major modes are an unstandardized mess:
;;
;; - ts-modes are wildly inconsistent when a language grammar is missing (some
;;   throw fatal errors, some respect `treesit-auto-install-grammar' and may
;;   attempt to install the grammar, others fall back to `fundamental-mode'
;;   silently).
;; - Some ts-modes clobber `auto-mode-alist' and/or `interpreter-mode-alist' up
;;   to three times:
;;
;;   a) In their autoloads,
;;   b) When the containing package is loaded,
;;   c) When the mode itself is activated.
;;
;;   Awful. This easily overrides user configuration or any custom file
;;   extensions the mode authors hadn't thought of. Even worse for built-in
;;   modes which won't see a fix until the next major Emacs release (with
;;   anywhere between 6 months and 5 years between them).
;;
;;   This module uses `set-tree-sitter!' to handle A & most cases of B,
;;   `+tree-sitter--maybe-remap-major-mode-a' to handle edge cases of B, and
;;   `+tree-sitter-ts-mode-inhibit-side-effects-a' to handle C, but only in
;;   ts-modes that are built into Emacs or managed by Doom's modules.
;; - Treesit does nothing to deal with ABI hell. The wrong Emacs version, built
;;   against the wrong tree-sitter libraries, coupled with the wrong grammar
;;   version... These are three points of failure that now fall to the user (or
;;   us) to resolve.
;;
;;   Built-in ts-modes (particularly older ones) install the latest commit of
;;   most grammars *blindly hoping* that Emacs was built with the right
;;   tree-sitter ABI that the grammar is expecting. Some (particularly newer or
;;   third-party) ts-modes will do some ABI version checks, but that assumes the
;;   grammars practice good ABI discipline (not as uncommon as I'd hoped).
;;   ts-modes can even use grammar features within the same ABI that may not
;;   survive Emacs releases! Sigh. What a mess!
;;
;; So how does this module attempt to wrangle all this silliness?
;;
;; - Standardizing how ts-modes react to missing grammars by advising
;;   `major-mode-remap' and performing all the grammar checks (and
;;   auto-installation steps, if desired) before the ts-modes have a chance to
;;   be silly.
;; - By throwing out hard-coded `auto-mode-alist' and `interpreter-mode-alist'
;;   entries and relying on `major-mode-remap-defaults' (which Doom backports
;;   for pre-30 users). Extra steps are taken to ensure ts-modes stay out of
;;   those mode alists after-the-fact.
;; - By defining our own list of grammar recipes that incrementally more
;;   ABI/feature gating than the ts-mode authors or Emacs devs do, and pray that
;;   they get around to dealing with it upstream one day.
;; - treesit imposes a couple breaking API changes between Emacs 29 and 30,
;;   without backwards compatibility. Guess that's our job now!
;;
;; More reading:
;; - https://cottontailia.github.io/the-day-tree-sitter-killed-portability/
;;
;;; Code:

(defvar +tree-sitter--commit-field? nil)


;;
;;; Packages

(use-package! treesit
  :when (treesit-available-p)
  :defer t
  :preface
  (setq treesit-enabled-modes t)

  ;; At 3 (the default), too many users think syntax highlighting is broken or
  ;; simply "looks off."
  (setq treesit-font-lock-level 4)

  ;; HACK: These built-in ts-modes clobber `auto-mode-alist' and/or
  ;;   `interpreter-mode-alist' every time they're activated, so suppress them!
  ;;   Fortunately, this has (mostly) been addressed in 31.1.
  ;; REVIEW: Remove when 30.x support is dropped
  (dolist (mode '(csharp-ts-mode    ; fixed in 31.1
                  css-ts-mode       ; fixed in 31.1
                  js-ts-mode        ; fixed in 31.1
                  python-ts-mode))  ; partially fixed in 31.1
    (advice-add mode :around #'+tree-sitter-ts-mode-inhibit-side-effects-a))

  ;; HACK: Intercept all ts-mode major mode remappings so grammars can be
  ;;   dynamically checked and `treesit-auto-install-grammar' can be
  ;;   consistently respected (which isn't currently the case with the majority
  ;;   of ts-modes, even the built-in ones across Emacs releases).
  (defadvice! +tree-sitter--maybe-remap-major-mode-a (fn mode)
    :around #'major-mode-remap
    (let ((mode (funcall fn mode)))
      (if-let* ((ts (get mode '+tree-sitter)) ; registered by `set-tree-sitter!'
                (fallback-mode (car ts)))
          (cond ((get mode '+tree-sitter-mode))
                ((not (eval-when-compile (treesit-available-p)))
                 (message "Treesit unavailable, falling back to `%S'" fallback-mode)
                 (put mode '+tree-sitter-mode fallback-mode))
                ((not (fboundp mode))
                 (message "Couldn't find `%S', falling back to `%S'" mode fallback-mode)
                 fallback-mode)
                ((and (or (eq treesit-enabled-modes t)
                          (memq fallback-mode treesit-enabled-modes))
                      ;; Lazily load autoloaded `treesit-language-source-alist'
                      ;; entries.
                      (let ((fn (symbol-function mode))
                            ;; Silence "can't find grammar" warning popups from
                            ;; `treesit-ready-p' calls in Emacs <=30.1. We'll
                            ;; log it to *Messages* instead.
                            (warning-suppress-types
                             (if doom-debug-mode
                                 warning-suppress-types
                               (cons '(treesit) warning-suppress-types)))
                            ;; For ts-modes that aren't registered with
                            ;; `set-tree-sitter!' and try to clobber these
                            ;; alists at load time.
                            auto-mode-alist
                            interpreter-mode-alist)
                        (or (not (autoloadp fn))
                            (autoload-do-load fn mode)))
                      ;; Only prompt once, and log other times.
                      (or (null (cdr ts))  ; no grammars, no problem!
                          ;; If the base/fallback mode doesn't exist, let's
                          ;; assume we want no fallthrough for this major mode
                          ;; and push forward anyway, even if a missing grammar
                          ;; results in a broken state.
                          (not (fboundp fallback-mode))
                          ;; Ensure grammars are present (and prompt to install
                          ;; them if needed).
                          (if-let* ((grammars
                                     (cl-loop for g in (cdr ts)
                                              unless (treesit-ready-p g 'message)
                                              collect g)))
                              (if (or (eq treesit-auto-install-grammar 'always)
                                      (if (eq treesit-auto-install-grammar 'ask)
                                          (and (not non-essential)
                                               (y-or-n-p
                                                (format "Missing tree-sitter grammars: %s\nInstall now?"
                                                        (mapconcat #'symbol-name grammars ", "))))))
                                  (mapc #'treesit-install-language-grammar grammars)
                                (message "Treesit grammars missing (%s), falling back to `%s'..."
                                         (mapconcat #'symbol-name grammars ", ")
                                         fallback-mode)
                                nil)
                            t)))
                 (put mode '+tree-sitter-mode mode))
                (fallback-mode))
        mode)))

  :config
  (setq +tree-sitter--commit-field?
        (eq (cdr (func-arity
                  (advice--cd*r
                   (advice--symbol-function 'treesit--install-language-grammar-1))))
            'many))

  ;; HACK: Keep $EMACSDIR clean by installing grammars to central location (the
  ;;   active profile).
  (let ((data-dir (doom-profile-data-dir t "tree-sitter")))
    (add-to-list 'treesit-extra-load-path data-dir)
    ;; Treesit's API saw major changes in 30.x.
    (if (< emacs-major-version 30)
        (defadvice! +tree-sitter--install-grammar-to-local-dir-a (fn out-dir &rest args)
          :around #'treesit--install-language-grammar-1
          (apply fn (or out-dir data-dir) args))
      (defadvice! +tree-sitter--install-grammar-to-local-dir-a (fn lang &optional out-dir &rest args)
        :around #'treesit-install-language-grammar
        :around #'treesit--build-grammar
        (apply fn lang (or out-dir data-dir) args))))

  (cl-defun +tree-sitter-source (name &key url rev source-dir cc cpp commit)
    (cons name
          (append (list url rev source-dir cc cpp)
                  ;; COMPAT: 31.1 introduced a COMMIT recipe argument.  On
                  ;;   <=30.x, extra arguments will trigger an arity error when
                  ;;   installing grammars.
                  (if +tree-sitter--commit-field?
                      (list commit)))))

  (dolist (map `(;; Module-less (or major-mode-less) grammars
                 (awk :url "https://github.com/Beaglefoot/tree-sitter-awk")
                 (bibtex :url "https://github.com/latex-lsp/tree-sitter-bibtex")
                 (blueprint :url "https://github.com/huanie/tree-sitter-blueprint")
                 (commonlisp :url "https://github.com/tree-sitter-grammars/tree-sitter-commonlisp")
                 (latex :url "https://github.com/latex-lsp/tree-sitter-latex"
                        :commit "a6c812704b3d3e1541b0853aa0d6d561301320e1") ; see latex-lsp/tree-sitter-latex#172
                 (make :url "https://github.com/tree-sitter-grammars/tree-sitter-make")
                 (nu :url "https://github.com/nushell/tree-sitter-nu")
                 (org :url "https://github.com/milisims/tree-sitter-org")
                 (perl :url "https://github.com/ganezdragon/tree-sitter-perl")
                 (proto :url "https://github.com/mitchellh/tree-sitter-proto")
                 (r :url "https://github.com/r-lib/tree-sitter-r")
                 (sql :url "https://github.com/DerekStride/tree-sitter-sql" :rev "gh-pages")
                 (surface :url "https://github.com/connorlay/tree-sitter-surface")
                 (toml :url "https://github.com/tree-sitter-grammars/tree-sitter-toml"
                       :rev "v0.7.0")
                 (typst :url "https://github.com/uben0/tree-sitter-typst"
                        :rev "master"
                        :source-dir "src")
                 (systemverilog :url "https://github.com/gmlarumbe/tree-sitter-systemverilog")
                 (vhdl :url "https://github.com/alemuller/tree-sitter-vhdl")
                 (vue :url "https://github.com/tree-sitter-grammars/tree-sitter-vue")
                 (wast :url "https://github.com/wasm-lsp/tree-sitter-wasm"
                       :source-dir "wast/src")
                 (wat :url "https://github.com/wasm-lsp/tree-sitter-wasm"
                      :source-dir "wat/src")
                 (wgsl :url "https://github.com/mehmetoguzderin/tree-sitter-wgsl")

                 ;; Grammars with modules
                 (ada :url "https://github.com/briot/tree-sitter-ada")
                 (c :url "https://github.com/tree-sitter/tree-sitter-c"
                    :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.6" "v0.24.1"))
                 (cpp :url "https://github.com/tree-sitter/tree-sitter-cpp"
                      :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.4")
                      :commit "80f5bd82d3b4a1acf07f34a569d88a4a29f74c42")
                 (cmake :url "https://github.com/uyha/tree-sitter-cmake")
                 (c-sharp :url "https://github.com/tree-sitter/tree-sitter-c-sharp"
                          :rev ,(if (< (treesit-library-abi-version) 15) "v0.20.0" "v0.23.1")
                          :commit "3431444351c871dffb32654f1299a00019280f2f")
                 (clojure :url "https://github.com/sogaiu/tree-sitter-clojure.git"
                          :rev "unstable-20250526")
                 (cuda :url "https://github.com/tree-sitter-grammars/tree-sitter-cuda")
                 (css :url "https://github.com/tree-sitter/tree-sitter-css"
                      :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.0" "v0.23.2"))
                 (dart :url "https://github.com/ast-grep/tree-sitter-dart")
                 (dockerfile :url "https://github.com/camdencheek/tree-sitter-dockerfile"
                             :commit "087daa20438a6cc01fa5e6fe6906d77c869d19fe")
                 (doxygen :url "https://github.com/tree-sitter-grammars/tree-sitter-doxygen"
                          :commit "1e28054cb5be80d5febac082706225e42eff14e6")
                 (elixir :url "https://github.com/elixir-lang/tree-sitter-elixir"
                         :commit "d24cecee673c4c770f797bac6f87ae4b6d7ddec5")
                 (erlang :url "https://github.com/WhatsApp/tree-sitter-erlang")
                 (fsharp :url "https://github.com/ionide/tree-sitter-fsharp"
                         :rev ,(if (< (treesit-library-abi-version) 15) "v0.1.0" "v0.2.0")
                         :commit "594c500ecace8618db32dd1144307897277db067")
                 (gdscript :url "https://github.com/PrestonKnopp/tree-sitter-gdscript.git"
                           :rev ,(if (< (treesit-library-abi-version) 15) "v5.0.1" "v6.1.0"))
                 (glsl :url "https://github.com/tree-sitter-grammars/tree-sitter-glsl")
                 (graphql :url "https://github.com/bkegley/tree-sitter-graphql")
                 (go :url "https://github.com/tree-sitter/tree-sitter-go"
                     :rev ,(if (< (treesit-library-abi-version) 15)
                               (if (< emacs-major-version 30) "v0.20.0" "v0.23.4")
                             "v0.25.0"))
                 (gomod :url "https://github.com/camdencheek/tree-sitter-go-mod"
                        :commit "3b01edce2b9ea6766ca19328d1850e456fde3103")
                 (gowork :url "https://github.com/omertuc/tree-sitter-go-work"
                         :commit "949a8a470559543857a62102c84700d291fc984c")
                 (gpr :url "https://github.com/brownts/tree-sitter-gpr")
                 (haskell :url "https://github.com/tree-sitter/tree-sitter-haskell")
                 (heex :url "https://github.com/phoenixframework/tree-sitter-heex"
                       :commit "b5a7cb5f74dc695a9ff5f04919f872ebc7a895e9")
                 (html :url "https://github.com/tree-sitter/tree-sitter-html"
                       :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.0" "v0.23.2"))
                 (janet-simple :url "https://github.com/sogaiu/tree-sitter-janet-simple"
                               :cc ,(if (featurep :system 'windows) "gcc.exe"))
                 (java :url "https://github.com/tree-sitter/tree-sitter-java"
                       :commit "94703d5a6bed02b98e438d7cad1136c01a60ba2c")
                 (javascript :url "https://github.com/tree-sitter/tree-sitter-javascript"
                             :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.0" "v0.25.0"))
                 (jsdoc :url "https://github.com/tree-sitter/tree-sitter-jsdoc"
                        :rev "v0.23.2")
                 (json :url "https://github.com/tree-sitter/tree-sitter-json"
                       :commit "4d770d31f732d50d3ec373865822fbe659e47c75")
                 (julia :url "https://github.com/tree-sitter/tree-sitter-julia")
                 (kotlin :url "https://github.com/fwcd/tree-sitter-kotlin")
                 (lua :url "https://github.com/tree-sitter-grammars/tree-sitter-lua"
                      :rev ,(if (< (treesit-library-abi-version) 15) "v0.3.0")
                      :commit "db16e76558122e834ee214c8dc755b4a3edc82a9")
                 (markdown :url "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                           :rev ,(if (< (treesit-library-abi-version) 15) "v0.4.1" "v0.5.3")
                           :source-dir "tree-sitter-markdown/src")
                 (markdown-inline :url "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                                  :rev ,(if (< (treesit-library-abi-version) 15) "v0.4.1" "v0.5.3")
                                  :source-dir "tree-sitter-markdown-inline/src")
                 (nix :url "https://github.com/nix-community/tree-sitter-nix")
                 (odin :url "https://github.com/tree-sitter-grammars/tree-sitter-odin"
                       :rev "v1.3.0")
                 (openscad :url "https://github.com/openscad/tree-sitter-openscad"
                           :rev "v0.7.1")
                 (php :url "https://github.com/tree-sitter/tree-sitter-php"
                      :rev "v0.23.11"
                      :commit ,(if (and (treesit-available-p)
                                        (< (treesit-library-abi-version) 15))
                                   "f7cf7348737d8cff1b13407a0bfedce02ee7b046"
                                 "5b5627faaa290d89eb3d01b9bf47c3bb9e797dea")
                      :source-dir "php/src")
                 (phpdoc :url "https://github.com/claytonrcarter/tree-sitter-phpdoc"
                         :commit "03bb10330704b0b371b044e937d5cc7cd40b4999")
                 (python :url "https://github.com/tree-sitter/tree-sitter-python"
                         :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.6" "v0.25.0"))
                 (regex :url "https://github.com/tree-sitter/tree-sitter-regex"
                        :rev "v0.24.3")
                 (ruby :url "https://github.com/tree-sitter/tree-sitter-ruby"
                       :commit "71bd32fb7607035768799732addba884a37a6210")
                 (rust :url "https://github.com/tree-sitter/tree-sitter-rust"
                       :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.2" "v0.24.2"))
                 (scala :url "https://github.com/tree-sitter/tree-sitter-scala")
                 (sml :url "https://github.com/MatthewFluet/tree-sitter-sml"
                      :rev ,(if (< (treesit-library-abi-version) 15) "v0.23.0")
                      :commit "fd4b4955bb998262840ab8119885b3edf20ea75a")
                 (swift :url "https://github.com/alex-pinkus/tree-sitter-swift"
                        :rev "0.7.1-with-generated-files")
                 (typescript :url "https://github.com/tree-sitter/tree-sitter-typescript"
                             :commit "8e13e1db35b941fc57f2bd2dd4628180448c17d5"
                             :source-dir "typescript/src")
                 (tsx :url "https://github.com/tree-sitter/tree-sitter-typescript"
                      :commit "8e13e1db35b941fc57f2bd2dd4628180448c17d5"
                      :source-dir "tsx/src")
                 (qmljs :url "https://github.com/yuja/tree-sitter-qmljs")
                 (yaml :url "https://github.com/tree-sitter-grammars/tree-sitter-yaml"
                       :rev ,(if (< (treesit-library-abi-version) 15) "v0.7.2" "v0.7.0"))
                 (zig :url "https://github.com/tree-sitter-grammars/tree-sitter-zig")))
    (cl-pushnew (apply #'+tree-sitter-source map)
                treesit-language-source-alist
                :key #'car
                :test #'eq)))


;; TODO: combobulate or evil-textobj-tree-sitter


;; (use-package! combobulate
;;   :commands combobulate-query-builder
;;   :hook (prog-mode . combobulate-mode))


;; (use-package! evil-textobj-tree-sitter
;;   :when (modulep! :editor evil +everywhere)
;;   :defer t
;;   :init (after! tree-sitter (require 'evil-textobj-tree-sitter))
;;   :after-call doom-first-input-hook
;;   :config
;;   (defvar +tree-sitter-inner-text-objects-map (make-sparse-keymap))
;;   (defvar +tree-sitter-outer-text-objects-map (make-sparse-keymap))
;;   (defvar +tree-sitter-goto-previous-map (make-sparse-keymap))
;;   (defvar +tree-sitter-goto-next-map (make-sparse-keymap))

;;   (evil-define-key '(visual operator) 'tree-sitter-mode
;;     "i" +tree-sitter-inner-text-objects-map
;;     "a" +tree-sitter-outer-text-objects-map)
;;   (evil-define-key 'normal 'tree-sitter-mode
;;     "[g" +tree-sitter-goto-previous-map
;;     "]g" +tree-sitter-goto-next-map)

;;   (map! (:map +tree-sitter-inner-text-objects-map
;;          "A" (+tree-sitter-get-textobj '("parameter.inner" "call.inner"))
;;          "f" (+tree-sitter-get-textobj "function.inner")
;;          "F" (+tree-sitter-get-textobj "call.inner")
;;          "C" (+tree-sitter-get-textobj "class.inner")
;;          "v" (+tree-sitter-get-textobj "conditional.inner")
;;          "l" (+tree-sitter-get-textobj "loop.inner"))
;;         (:map +tree-sitter-outer-text-objects-map
;;          "A" (+tree-sitter-get-textobj '("parameter.outer" "call.outer"))
;;          "f" (+tree-sitter-get-textobj "function.outer")
;;          "F" (+tree-sitter-get-textobj "call.outer")
;;          "C" (+tree-sitter-get-textobj "class.outer")
;;          "c" (+tree-sitter-get-textobj "comment.outer")
;;          "v" (+tree-sitter-get-textobj "conditional.outer")
;;          "l" (+tree-sitter-get-textobj "loop.outer"))

;;         (:map +tree-sitter-goto-previous-map
;;          "a" (+tree-sitter-goto-textobj "parameter.outer" t)
;;          "f" (+tree-sitter-goto-textobj "function.outer" t)
;;          "F" (+tree-sitter-goto-textobj "call.outer" t)
;;          "C" (+tree-sitter-goto-textobj "class.outer" t)
;;          "c" (+tree-sitter-goto-textobj "comment.outer" t)
;;          "v" (+tree-sitter-goto-textobj "conditional.outer" t)
;;          "l" (+tree-sitter-goto-textobj "loop.outer" t))
;;         (:map +tree-sitter-goto-next-map
;;          "a" (+tree-sitter-goto-textobj "parameter.outer")
;;          "f" (+tree-sitter-goto-textobj "function.outer")
;;          "F" (+tree-sitter-goto-textobj "call.outer")
;;          "C" (+tree-sitter-goto-textobj "class.outer")
;;          "c" (+tree-sitter-goto-textobj "comment.outer")
;;          "v" (+tree-sitter-goto-textobj "conditional.outer")
;;          "l" (+tree-sitter-goto-textobj "loop.outer")))

;;   (after! which-key
;;     (setq which-key-allow-multiple-replacements t)
;;     (pushnew!
;;      which-key-replacement-alist
;;      '(("" . "\\`+?evil-textobj-tree-sitter-function--\\(.*\\)\\(?:.inner\\|.outer\\)") . (nil . "\\1")))))
