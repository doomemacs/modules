;; -*- no-byte-compile: t; -*-
;;; tools/eval/packages.el

(package! quickrun :pin "a25264bead36ea4cb8c6fe6ba3755508f5cb8d83")
(when (modulep! +overlay)
  (package! eros :pin "66ee90baa3162fea028f5101ddcc370f7d1d4fcf"))
