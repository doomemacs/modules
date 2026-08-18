;; -*- no-byte-compile: t; -*-
;;; lang/scad/packages.el

(package! scad-mode :pin "b5b795cf54b416bcd3245e88835662e4ec7c3dc3")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! scad-ts-mode :pin "9a61e0ad7a9cf2c4274553a35fc8643506d40c68"))
