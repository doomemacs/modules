;; -*- no-byte-compile: t; -*-
;;; lang/prisma/packages.el

(package! prisma-mode
  :recipe (:host github :repo "pimeys/emacs-prisma-mode"
           :files ("prisma-mode.el"))
  :pin "f7744a995e84b8cf51265930ce18f6a6b26dade7")
