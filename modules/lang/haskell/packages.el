;; -*- no-byte-compile: t; -*-
;;; lang/haskell/packages.el

(package! haskell-mode :pin "781e4669a0e0917fa8c532371cbfb1eb5b03b645")
(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! haskell-ts-mode :pin "bf143ee8382f09e0a68d775d80445065f32929c3"))

(when (and (modulep! +lsp)
           (modulep! :tools lsp -eglot))
  (package! lsp-haskell :pin "49e39b2bc02014110805f950758716615d96cd3c"))
