;; -*- no-byte-compile: t; -*-
;;; lang/zig/packages.el

(package! zig-mode :pin "62bfbaced0222e2bfbc086fa8556adf6b3298476")

(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (version<= "30.1" emacs-version))
  (package! zig-ts-mode :pin "4c03d52bd1e7f1b5601c638bff109b6e763b1cab"))
