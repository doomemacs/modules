;; -*- no-byte-compile: t; -*-
;;; lang/julia/packages.el

(package! julia-mode :pin "1b5a4c2f5b7c3f842785985bf8778b8805cc6766")
(package! julia-repl :pin "0173237a43d9a42f0d69a5405283fabe1ac602a0")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! julia-ts-mode :pin "d53fb5b2c7e83223dcd8c7ae6bd5e1abf18665f6"))

(when (modulep! +lsp)
  (if (modulep! :tools lsp +eglot)
      (package! eglot-jl :pin "ebe4358b48827a85dd4c714bcc3db11842aa6c3c")
    (package! lsp-julia :pin "c869b2f6c05a97e5495ed3cc6710a33b4faf41a2")))

(when (modulep! +snail)
  (package! julia-snail :pin "6c545d67e93590d1155b60e79384481438cb7527"))
