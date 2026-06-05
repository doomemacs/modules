;; -*- no-byte-compile: t; -*-
;;; checkers/spell/packages.el

(if (modulep! -flyspell)
    (package! spell-fu
      :recipe (:host github :repo "emacsmirror/spell-fu")
      :pin "94686051261a065574fc6535979f8ff08a37f0ee")
  (package! flyspell-correct :pin "c6dfb9bebb90ecbcaa3fbd4d747a677e17698e02")
  (cond ((modulep! :completion ivy)
         (package! flyspell-correct-ivy))
        ((modulep! :completion helm)
         (package! flyspell-correct-helm))
        ((not (modulep! :completion vertico))
         (package! flyspell-correct-popup)))
  (package! flyspell-lazy :pin "0fc5996bcee20b46cbd227ae948d343c3bef7339"))
