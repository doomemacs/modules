;; -*- no-byte-compile: t; -*-
;;; ui/ophints/packages.el

(if (modulep! :editor evil)
    (package! evil-goggles :pin "34ca276a85f615d2b45e714c9f8b5875bcb676f3")
  (package! goggles :pin "e473909708aa0df2134b7bb7f6654d0fb5f23e23"))
