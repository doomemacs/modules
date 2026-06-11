;; -*- no-byte-compile: t; -*-
;;; lang/scad/packages.el

(package! scad-mode :pin "8798dca")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! scad-ts-mode :pin "9a61e0a"))
