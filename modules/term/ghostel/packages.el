;; -*- no-byte-compile: t; -*-
;;; term/ghostel/packages.el

(package! ghostel
  :recipe (:host github :repo "dakra/ghostel")
  :pin "a63db707e0d71e49eb4de95b198e288788eb92f8")

(when (modulep! :editor evil +everywhere)
  (package! evil-ghostel
    :recipe (:host github :repo "dakra/ghostel"
             :files ("extensions/evil-ghostel/*.el"))
    :pin "a63db707e0d71e49eb4de95b198e288788eb92f8"))
