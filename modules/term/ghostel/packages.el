;; -*- no-byte-compile: t; -*-
;;; term/ghostel/packages.el

(package! ghostel
  :recipe (:host github :repo "dakra/ghostel")
  :pin "dd72e1f4ae891345a1f76ed98c5cbd71c18e808e")

(when (modulep! :editor evil +everywhere)
  (package! evil-ghostel
    :recipe (:host github :repo "dakra/ghostel"
             :files ("extensions/evil-ghostel/*.el"))
    :pin "dd72e1f4ae891345a1f76ed98c5cbd71c18e808e"))
