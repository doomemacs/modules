;; -*- no-byte-compile: t; -*-
;;; lang/scala/packages.el

(package! sbt-mode :pin "3da084aa438179913f1fdd770f0be136c6f66322")
(package! scala-mode :pin "50bcafa181baec7054e27f4bca55d5f9277c6350")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! scala-ts-mode :pin "a1f25865a3c2772b91f5bf95457411b45244ea1e"))

(when (and (modulep! +lsp)
           (modulep! :tools lsp -eglot))
  (package! lsp-metals :pin "afeacc7a528b80b9a9f2747428e5608c264201ec"))
