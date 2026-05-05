;; -*- no-byte-compile: t; -*-
;;; lang/kotlin/packages.el

(package! kotlin-mode :pin "fddd747e5b4736e8b27a147960f369b86179ddff")

(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (> emacs-major-version 29))  ; upstream constraint
  (package! kotlin-ts-mode :pin "588764613a45a0baf3adffcd68066991f9e56191"))

(when (modulep! :checkers syntax -flymake)
  (package! flycheck-kotlin :pin "a2a6abb9a7f85c6fb15ce327459ec3c8ff780188"))
