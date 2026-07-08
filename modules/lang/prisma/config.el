;;; lang/prisma/config.el -*- lexical-binding: t; -*-

(use-package! prisma-mode
  :defer t
  :config
  (when (modulep! +lsp)
    (add-hook 'prisma-mode-local-vars-hook #'lsp! 'append))
  (when (modulep! +tree-sitter)
    (set-tree-sitter! 'prisma-mode
      '((prisma :url "https://github.com/victorhqc/tree-sitter-prisma"
                :rev "v1.6.0"))))
  (map! :localleader
        :map prisma-mode-map
        "f" #'prisma-format-buffer))
