;;; ui/ligatures/config.el -*- lexical-binding: t; -*-

(defvar +ligatures-extra-symbols
  '(;; org
    :name          "»"
    :src_block     "»"
    :src_block_end "«"
    :quote         "“"
    :quote_end     "”"
    ;; Functional
    :lambda        "λ"
    :def           "ƒ"
    :composition   "∘"
    :map           "↦"
    ;; Types
    :null          "∅"
    :true          "𝕋"
    :false         "𝔽"
    :int           "ℤ"
    :float         "ℝ"
    :str           "𝕊"
    :bool          "𝔹"
    :list          "𝕃"
    ;; Flow
    :not           "￢"
    :in            "∈"
    :not-in        "∉"
    :and           "∧"
    :or            "∨"
    :for           "∀"
    :some          "∃"
    :return        "⟼"
    :yield         "⟻"
    ;; Other
    :union         "⋃"
    :intersect     "∩"
    :diff          "∖"
    :tuple         "⨂"
    :pipe          "" ;; FIXME: find a non-private char
    :dot           "•")
  "Maps identifiers to symbols, recognized by `set-ligatures'.

This should not contain any symbols from the Unicode Private Area! There is no
universal way of getting the correct symbol as that area varies from font to
font.")

(defvar +ligatures-alist
  '((prog-mode "|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
               ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
               "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
               "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
               "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
               "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
               "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
               "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
               ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
               "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
               "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
               "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
               "\\\\" "://")
    (t))
  "A alist of ligatures to enable in specific modes.

To configure this variable, use `set-ligatures!'.")

(defvar +ligatures-in-modes nil
  "List of major modes where ligatures should be enabled.")
(make-obsolete-variable '+ligatures-in-modes "Use `ligature-ignored-major-modes' instead" "24.10.0")

(defvar +ligatures-prog-mode-list nil
  "A list of ligatures to enable in all `prog-mode' buffers.")
(make-obsolete-variable '+ligatures-prog-mode-list "Use `+ligatures-alist' instead" "24.09.0")

(defvar +ligatures-all-modes-list nil
  "A list of ligatures to enable in all buffers.")
(make-obsolete-variable '+ligatures-all-modes-list "Use `+ligatures-alist' instead" "24.09.0")

(defvar +ligatures-extra-alist '((t))
  "A map of major modes to symbol lists (for `prettify-symbols-alist').

To configure this variable, use `set-ligatures!'.")

(defvar +ligatures-extras-in-modes t
  "List of major modes where extra ligatures should be enabled.

Extra ligatures are mode-specific substituions, defined in
`+ligatures-extra-symbols' and assigned with `set-ligatures!'. This variable
controls where these are enabled.

  If t, enable it everywhere (except `fundamental-mode').
  If the first element is not, enable it in any mode besides what is listed.
  If nil, don't enable these extra ligatures anywhere (though it's more
efficient to remove the `+extra' flag from the :ui ligatures module instead).")

(defun +ligatures--enable-p (modes)
  "Return t if ligatures should be enabled in this buffer depending on MODES."
  (unless (eq major-mode 'fundamental-mode)
    (or (eq modes t)
        (if (eq (car modes) 'not)
            (not (apply #'derived-mode-p (cdr modes)))
          (apply #'derived-mode-p modes)))))

(defun +ligatures-init-extra-symbols-h ()
  "Set up `prettify-symbols-mode' for the current buffer.

Overwrites `prettify-symbols-alist' and activates `prettify-symbols-mode' if
(and only if) there is an associated entry for the current major mode (or a
parent mode) in `+ligatures-extra-alist' AND the current mode (or a parent mode)
isn't disabled in `+ligatures-extras-in-modes'."
  (when after-init-time
    (when-let*
        (((+ligatures--enable-p +ligatures-extras-in-modes))
         (symbols
          (if-let* ((symbols (assq major-mode +ligatures-extra-alist)))
              (cdr symbols)
            (cl-loop for (mode . symbols) in +ligatures-extra-alist
                     if (derived-mode-p mode)
                     return symbols))))
      (setq prettify-symbols-alist
            (append symbols
                    ;; Don't overwrite global defaults
                    (default-value 'prettify-symbols-alist)))
      (when (bound-and-true-p prettify-symbols-mode)
        (prettify-symbols-mode -1))
      (prettify-symbols-mode +1))))


;;
;;; Bootstrap

;;;###package prettify-symbols
;; When you get to the right edge, it goes back to how it normally prints
(setq prettify-symbols-unprettify-at-point 'right-edge)

(when (modulep! +extra)
  (add-hook 'after-change-major-mode-hook #'+ligatures-init-extra-symbols-h))

(cond
 ;; The emacs-mac build of Emacs appears to have built-in support for ligatures,
 ;; using the same composition-function-table method
 ;; https://bitbucket.org/mituharu/emacs-mac/src/26c8fd9920db9d34ae8f78bceaec714230824dac/lisp/term/mac-win.el?at=master#lines-345:805
 ;; so use that instead if this module is enabled.
 ((if (featurep :system 'macos)
      (fboundp 'mac-auto-operator-composition-mode))
  (add-hook 'doom-init-ui-hook #'mac-auto-operator-composition-mode 'append))

 ((and (or (featurep 'ns)
           (string-match-p "HARFBUZZ" system-configuration-features))
       (featurep 'composite))   ; Emacs loads `composite' at startup

  (after! ligature
    ;; DEPRECATED: For backwards compatibility. Remove later.
    (with-no-warnings
      (when +ligatures-prog-mode-list
        (setf (alist-get 'prog-mode +ligatures-alist) +ligatures-prog-mode-list))
      (when +ligatures-all-modes-list
        (setf (alist-get t +ligatures-alist) +ligatures-all-modes-list)))
    (dolist (lig +ligatures-alist)
      (ligature-set-ligatures (car lig) (cdr lig))))

  (add-hook 'doom-init-ui-hook #'global-ligature-mode 'append)))
