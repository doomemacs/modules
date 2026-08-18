;; -*- no-byte-compile: t; -*-
;;; lang/fsharp/packages.el

(package! fsharp-mode :pin "5212c9359180c0a3c01f22060d9836d5165988a3")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! fsharp-ts-mode :pin "5f6652d60c6eff44a2b44693d8229648f0875b48"))
