;;; lang/yaml/config.el -*- lexical-binding: t; -*-

(use-package! yaml-mode
  :mode "Procfile\\'"
  :init
  (when (modulep! +tree-sitter)
    ;; HACK: `yaml-ts-mode' doesn't implement any indentation (falling back to
    ;;   `indent-relative'), so borrow `yaml-mode's. See
    ;;   https://debbugs.gnu.org/cgi/bugreport.cgi?bug=77094.
    (setq-hook! 'yaml-ts-mode-hook indent-line-function #'yaml-indent-line))
  :config
  (when (modulep! +lsp)
    (add-hook 'yaml-mode-local-vars-hook #'lsp! 'append)))


(use-package! yaml-ts-mode  ; 29.1+ only
  :when (modulep! +tree-sitter)
  :defer t
  :init
  (set-tree-sitter! 'yaml-mode 'yaml-ts-mode 'yaml)
  :config
  (when (modulep! +lsp)
    (add-hook 'yaml-ts-mode-local-vars-hook #'lsp! 'append)))
