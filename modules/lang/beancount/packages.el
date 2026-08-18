;; -*- no-byte-compile: t; -*-
;;; lang/beancount/packages.el

(package! beancount
  :recipe (:host github
           :repo "beancount/beancount-mode")
  :pin "37648f983ff42426b1f364831ce7d2d0d735686b")
