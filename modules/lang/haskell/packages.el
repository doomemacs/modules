;; -*- no-byte-compile: t; -*-
;;; lang/haskell/packages.el

(package! haskell-mode :pin "f957090cfb2fb8757a06750c6438561b21419f86")
(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! haskell-ts-mode :pin "673c27eb86ced050c6b3f46920d081fcb257fee4"))

(when (and (modulep! +lsp)
           (modulep! :tools lsp -eglot))
  (package! lsp-haskell :pin "49e39b2bc02014110805f950758716615d96cd3c"))
