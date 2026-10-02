;; -*- no-byte-compile: t; -*-
;;; tools/upload/packages.el

(package! ssh-deploy
  :recipe (:host github :repo "emacsmirror/ssh-deploy")
  :pin "d33b081828c9a13730ff2af8dc548ad6eeeea61f")
