;; -*- no-byte-compile: t; -*-
;;; app/emms/packages.el

(package! emms
  :recipe (:host github
           :repo "emacs-straight/emms"
           :files (:defaults (:exclude "doc/fdl.texi" "doc/gpl.texi")))
  :pin "d4ca43959f76bf8afc1261cdd06b2a419fe058a0")
