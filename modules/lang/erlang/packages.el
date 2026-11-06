;; -*- no-byte-compile: t; -*-
;;; lang/erlang/packages.el

(package! erlang :pin "9c6d4fe9aefa7d643d857e3110ed0541a5f92760")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! erlang-ts :pin "4e9095be49630dc279c70033245a7e1051614f92"))
