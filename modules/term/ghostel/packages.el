;; -*- no-byte-compile: t; -*-
;;; term/ghostel/packages.el

(package! ghostel
  :recipe (:host github :repo "dakra/ghostel")
  :pin "0f0a9bddb150c431a32742efca4b19a51a59b042")

(when (modulep! :editor evil +everywhere)
  (package! evil-ghostel
    :recipe (:host github :repo "dakra/ghostel"
             :files ("extensions/evil-ghostel/*.el"))
    :pin "0f0a9bddb150c431a32742efca4b19a51a59b042"))
