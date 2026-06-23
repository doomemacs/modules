;; -*- no-byte-compile: t; -*-
;;; checkers/spell/packages.el

(if (modulep! -flyspell)
    (package! spell-fu
      :recipe (:host github :repo "emacsmirror/spell-fu")
      :pin "103c4aaf0d2ec452359e087bed50504e2bdf4661")
  (package! flyspell-correct :pin "7b891abf9baf6cc5935a46ffe0bf4656ffd5d0d2")
  (cond ((modulep! :completion ivy)
         (package! flyspell-correct-ivy))
        ((modulep! :completion helm)
         (package! flyspell-correct-helm))
        ((not (modulep! :completion vertico))
         (package! flyspell-correct-popup)))
  (package! flyspell-lazy :pin "0fc5996bcee20b46cbd227ae948d343c3bef7339"))
