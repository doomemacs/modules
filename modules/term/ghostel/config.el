;;; term/ghostel/config.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package! ghostel
  :when (bound-and-true-p module-file-suffix) ; requires dynamic-modules support
  ;; The mode-line and line number serves little purpose in a terminal, so free
  ;; up the real estate. Also seconds as a visual indicator that the ghostel
  ;; buffer is special.
  :hook (ghostel-mode . mode-line-invisible-mode)
  :hook (ghostel-mode . doom-disable-line-numbers-h)
  :init
  (when (modulep! +everywhere)
    (add-hook 'comint-mode-hook #'ghostel-comint-mode)
    ;; HACK: Done to lazy-load this package until first invocation.
    (setq ghostel-compile-global-mode t)
    (autoload 'ghostel-compile--compilation-start-advice "ghostel-compile")
    (advice-add 'compilation-start :around #'ghostel-compile--compilation-start-advice))

  ;; REVIEW: PR more elegant solution to solaire-mode.
  (add-hook! 'solaire-global-mode-hook :append
    (defun +ghostel-init-solaire-h ()
      (with-eval-after-load 'ghostel-faces
        (let ((fc (if solaire-global-mode 'solaire-default-face 'default)))
          (dolist (fr (cons t (frame-list)))
            (set-face-attribute 'ghostel-default fr :inherit fc))))))
  :config
  (add-to-list 'doom-real-buffer-modes 'ghostel-mode)

  ;; HACK: See dakra/ghostel#456. Persp-mode stores buffers by name, so if
  ;;   ghostel renames a buffer, persp-mode will lose track of it.
  (when (modulep! :ui workspaces)
    (setq ghostel-buffer-name-function nil))

  ;; HACK: direnv will silently no-op in ghostel shells if direnv.el/envrc.el
  ;;   has already run, or if Emacs was launched from a direnv'ed environment,
  ;;   so unset its init vars to allow it to run again as needed.
  ;; REVIEW: PR this upstream?
  (add-hook! 'ghostel-pre-spawn-hook
    (defun +ghostel-strip-direnv-initvars-h (&rest _)
      (when (getenv "DIRENV_FILE")
        (setq-local process-environment
                    (seq-filter (fn! (string-prefix-p "DIRENV_" %))
                                process-environment))))))


(use-package! ghostel-eshell
  :when (modulep! +everywhere)
  :hook (eshell-load . ghostel-eshell-visual-command-mode)
  :init
  (with-eval-after-load 'em-term
    (add-to-list 'eshell-visual-commands "btop" t)))


(use-package! evil-ghostel
  :when (modulep! :editor evil +everywhere)
  :hook (ghostel-mode . evil-ghostel-mode))
