;;; lang/yaml/config.el -*- lexical-binding: t; -*-

(use-package! yaml-mode
  :mode "Procfile\\'"
  :config
  (when (modulep! +lsp)
    (add-hook 'yaml-mode-local-vars-hook #'lsp! 'append)))


(use-package! yaml-ts-mode  ; 29.1+ only
  :when (modulep! +tree-sitter)
  :defer t
  :init
  (set-tree-sitter! 'yaml-mode 'yaml-ts-mode 'yaml)
  :config
  ;; HACK: `yaml-ts-mode' does not implements any indentation,
  ;; leaving it on `indent-relative'. Borrow `yaml-mode's
  ;; indenter, it is installed regardless by this module.
  ;; See upstream GNU bug report: #77094
  (add-hook 'yaml-ts-mode-hook
            (defun +yaml-use-yaml-mode-indentation-h ()
              (require 'yaml-mode)
              (setq-local indent-line-function #'yaml-indent-line)))
  (when (modulep! +lsp)
    (add-hook 'yaml-ts-mode-local-vars-hook #'lsp! 'append)))
