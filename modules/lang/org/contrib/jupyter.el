;;; lang/org/contrib/jupyter.el -*- lexical-binding: t; -*-
;;;###if (modulep! +jupyter)
;; TODO: Move to :tools jupyter

(use-package! jupyter-client
  :defer t
  :config
  ;; HACK: Jupyter's capf advertises a `:company-doc-buffer' function that calls
  ;;   `company-doc-buffer' unconditionally, so anything else that consumes it
  ;;   (e.g. `corfu-popupinfo') throws void-function errors if company isn't
  ;;   installed. Give it a stand-in in that case.
  ;; REVIEW: Upstream this (not fixed as of emacs-jupyter/jupyter@05ea8406).
  (defadvice! +org-jupyter--fix-doc-buffer-without-company-a (fn &rest args)
    :around #'jupyter-completion--company-doc-buffer
    (if (fboundp 'company-doc-buffer)
        (apply fn args)
      (cl-letf (((symbol-function 'company-doc-buffer)
                 (lambda (&rest _)
                   (with-current-buffer (get-buffer-create " *jupyter-doc*")
                     (let ((inhibit-read-only t))
                       (erase-buffer))
                     (fundamental-mode)
                     (current-buffer)))))
        (apply fn args)))))


(use-package! jupyter-repl
  :defer t
  :config
  ;; HACK: Don't use treesit ts-modes for syntax highlighting (is brittle).
  (defadvice! +org-jupyter--suppress-major-mode-remapping-a (fn &rest args)
    :around #'jupyter-kernel-language-mode-properties
    (dlet (major-mode-remap-alist major-mode-remap-defaults)
      (apply fn args)))

  ;; HACK: And un-remap the major mode when associating a repl with the current
  ;;   buffer, otherwise it will fail with any treesit-enabled (or otherwise
  ;;   remapped) modes.
  (defadvice! +org-jupyter--unremap-major-mode-when-associating-buffer-a (fn &rest args)
    :around #'jupyter-repl-associate-buffer
    (dlet ((major-mode
            (or (car (rassq major-mode (append major-mode-remap-alist
                                               major-mode-remap-defaults)))
                major-mode)))
      (apply fn args)))

  ;; HACK: If the user is anywhere but the last prompt, typing should move them
  ;;   there instead of unhelpfully spewing read-only errors at them.
  ;; REVIEW: Upstream this (maybe?)
  (defun +jupyter--move-cursor-to-prompt-h ()
    (and (eq this-command 'self-insert-command)
         (> (save-excursion
              (goto-char (point-max))
              (jupyter-repl-cell-code-beginning-position))
            (point))
         (goto-char (point-max))))

  (add-hook! 'jupyter-repl-mode-hook
    (defun +jupyter--init-move-cursor-to-prompt-h ()
      (add-hook 'pre-command-hook #'+jupyter--move-cursor-to-prompt-h
                nil t))))


(use-package! jupyter-org-client
  :defer t
  :config
  ;; Already handled by `+org--ob-jupyter-initiate-session-a'
  (remove-hook 'org-mode-hook #'jupyter-org-interaction-mode))


(use-package! ob-jupyter
  :defer t
  :init
  ;; HACK: ob-juypter don't support ob-async and handles async itself, so
  ;;   piggyback off of `org-babel-jupyter-make-language-alias' to disable it
  ;;   for every current and future kernel language.
  (defadvice! +org-jupyter--suppress-ob-async-a (_kernel lang)
    :before #'org-babel-jupyter-make-language-alias
    (with-eval-after-load 'ob-async
      (add-to-list 'ob-async-no-async-languages-alist (concat "jupyter-" lang))))

  (add-hook! '+org-babel-load-functions
    (defun +org-babel-load-jupyter-h (lang)
      (and (string-prefix-p "jupyter-" (symbol-name lang))
           (require 'ob-jupyter nil t)
           (org-babel-jupyter-make-local-aliases))))

  :config
  (defadvice! +org--ob-jupyter-initiate-session-a (&rest _)
    :after #'org-babel-jupyter-initiate-session
    (unless (bound-and-true-p jupyter-org-interaction-mode)
      (jupyter-org-interaction-mode)))

  (require 'tramp))
