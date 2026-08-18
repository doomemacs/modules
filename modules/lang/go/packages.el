;; -*- no-byte-compile: t; -*-
;;; lang/go/packages.el

(package! go-mode :pin "3a71d28ab47df685e54ca6046a7a3dd3e28b682c")
(package! gorepl-mode :pin "6a73bf352e8d893f89cad36c958c4db2b5e35e07")
(package! go-tag :pin "33f2059551d5298ca228d90f525b99d1a8d70364")
(package! go-gen-test :pin "af00a9abbaba2068502327ecdef574fd894a884b")

(when (modulep! :checkers syntax -flymake)
  (package! flycheck-golangci-lint :pin "51aede797df89eeea5928df05d0f619530339152"))
