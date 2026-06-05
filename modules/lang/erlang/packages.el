;; -*- no-byte-compile: t; -*-
;;; lang/erlang/packages.el

(package! erlang :pin "ad8027027f71738c5ffaf86b3e0bc9d2b45048ac")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! erlang-ts :pin "4e9095be49630dc279c70033245a7e1051614f92"))
