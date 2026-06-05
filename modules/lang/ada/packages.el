;; -*- no-byte-compile: t; -*-
;;; lang/ada/packages.el

(package! ada-mode :pin "ce8a2dfebc2b738f32b61dbe2668f7acb885db93")
(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! ada-ts-mode :pin "e3b094ed138aeba4ad22114701a1828e20384207"))
(package! gpr-mode :pin "03141c6b9a39c31a6e759b594b41617b97b02753")
(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! gpr-ts-mode :pin "cd10a0963b4cf64966bb2e9413d787d83f5494d5"))
