;; -*- no-byte-compile: t; -*-
;;; tools/tree-sitter/packages.el

(package! treesit :built-in t)
(when (> emacs-major-version 28)
  (when (modulep! :editor evil +everywhere)
    (package! evil-textobj-tree-sitter
      :pin "fecc0e11615df31a6651ce11b012388e53cad4e9"))
  )
