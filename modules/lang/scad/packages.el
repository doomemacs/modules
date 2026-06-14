;; -*- no-byte-compile: t; -*-
;;; lang/scad/packages.el

(package! scad-mode :pin "8798dca7e919705bcbc35d4ab5639556827ccb6f")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! scad-ts-mode :pin "9a61e0ad7a9cf2c4274553a35fc8643506d40c68"))
