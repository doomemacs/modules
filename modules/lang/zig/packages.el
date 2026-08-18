;; -*- no-byte-compile: t; -*-
;;; lang/zig/packages.el

(package! zig-mode :pin "62bfbaced0222e2bfbc086fa8556adf6b3298476")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! zig-ts-mode :pin "bb1e8287800868ee338e986bda5b5a1f5abf7445"))
