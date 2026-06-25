;; -*- no-byte-compile: t; -*-
;;; term/ghostel/packages.el

(package! ghostel
  :recipe (:host github :repo "dakra/ghostel")
  :pin "b6d7b37353572bf92d04c8de5abced3ef68a0304")

(when (and (modulep! +evil) (modulep! :editor evil))
  (package! evil-ghostel
    :recipe (:host github :repo "dakra/ghostel"
             :files ("extensions/evil-ghostel/*.el"))
    :pin "b6d7b37353572bf92d04c8de5abced3ef68a0304"))
