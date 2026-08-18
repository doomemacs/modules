;; -*- no-byte-compile: t; -*-
;;; lang/odin/packages.el

(package! odin-mode
  :recipe (:host github :repo "mattt-b/odin-mode")
  :pin "21c6ff8b49f5eaa2d3b9969feeb08de921f11e92")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! odin-ts-mode
    :recipe (:host github :repo "Sampie159/odin-ts-mode")
    :pin "138bf6871b5e703ba5ad3f1c3464e2b4ce0fa846"))
