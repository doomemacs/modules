;; -*- no-byte-compile: t; -*-
;;; lang/kotlin/packages.el

(package! kotlin-mode :pin "fddd747e5b4736e8b27a147960f369b86179ddff")

(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (> emacs-major-version 29))  ; upstream constraint
  (package! kotlin-ts-mode :pin "39e30e4cf803910c2f6716efd7a5cd408a9d996b"))

(when (modulep! :checkers syntax -flymake)
  (package! flycheck-kotlin :pin "a2a6abb9a7f85c6fb15ce327459ec3c8ff780188"))
