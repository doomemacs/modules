;; -*- no-byte-compile: t; -*-
;;; lang/scala/packages.el

(package! sbt-mode :pin "c353df6aa112c05dde6dc63ccf813c2203cb472b")
(package! scala-mode :pin "50bcafa181baec7054e27f4bca55d5f9277c6350")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! scala-ts-mode :pin "c7671e10419261ef70b1820d3b970ad39f6fcfe2"))

(when (and (modulep! +lsp)
           (modulep! :tools lsp -eglot))
  (package! lsp-metals :pin "afeacc7a528b80b9a9f2747428e5608c264201ec"))
