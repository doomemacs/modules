;; -*- no-byte-compile: t; -*-
;;; term/ghostel/packages.el

(package! ghostel
  :recipe (:host github :repo "dakra/ghostel")
  :pin "df9b7e1ab3bb2a5305232f02f7619e4e2f0570b4")

(when (modulep! :editor evil +everywhere)
  (package! evil-ghostel
    :recipe (:host github :repo "dakra/ghostel"
             :files ("extensions/evil-ghostel/*.el"))
    :pin "df9b7e1ab3bb2a5305232f02f7619e4e2f0570b4"))
