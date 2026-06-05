;; -*- no-byte-compile: t; -*-
;;; core/use-package/packages.el

(package! bind-key
  ;; HACK: bind-key-pkg.el in the emacs-straight mirror tries to set the mode to
  ;;   lisp-data-mode, which doesn't exist prior to Emacs 28.x, so bind-key will
  ;;   fail to build for those users. Until we drop 27.x support, we omit it.
  :recipe (:files ("bind-key.el"))
  :pin "6ff8788e347ce31b5c3c4647c2e22e7ee2c5ab7c")

(package! use-package :pin "4b3484b550431f74ab9cda060a8dc983fe482131")
