;; -*- no-byte-compile: t; -*-
;;; lang/fsharp/packages.el

(package! fsharp-mode :pin "5212c9359180c0a3c01f22060d9836d5165988a3")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! fsharp-ts-mode :pin "415dcaf2cb83d98af86ae072a11eae2558047c6c"))
