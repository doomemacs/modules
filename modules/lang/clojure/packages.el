;; -*- no-byte-compile: t; -*-
;;; lang/clojure/packages.el

;; HACK: Fix doomemacs/core#5577. Paredit is a cider dependency. We install
;;   paredit ourselves to get it from emacsmirror, because the original upstream
;;   is a custom git server with shallow clones disabled.
(package! paredit
  :recipe (:host github :repo "emacsmirror/paredit")
  :pin "af075775af91f2dbc63b915d762b4aec092946c4")

;; HACK: Forward declare these clj-refactor/cider deps so that their deps are
;;   byte-compiled first.
(package! parseclj :pin "249079da5c2655a8e503b33280c1ab1341e72de2")
(package! parseedn :pin "6ab98d33ae175f28e4bbf1df874030e1ff7b7add")

;;; Core packages
(package! clojure-mode :pin "d864d6f26c8acc576fc7fc343299c240909f27ac")
(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (> emacs-major-version 29))  ; requires 30+
  (package! clojure-ts-mode :pin "51df988a3874e2f02a64f2d67b6ef97c7fc987b8"))
(package! clj-refactor :pin "2805bd5f505fdb199a8c5a25fca398ec9c161e5b")
(package! cider :pin "1f0a1d13f3e879f6b795eecf44ee5df54b23e5b5")
(when (modulep! :checkers syntax -flymake)
  (package! flycheck-clj-kondo :pin "414a3ead1faefb234d658fd8a8ba121c95b71de2"))
(package! jet :pin "c9a92675efd802f37df5e3eab7858dbbeced6ea4")
(package! neil
  :recipe (:host github :repo "babashka/neil" :files ("*.el"))
  :pin "7661200e98b9380db8092ce7f614c5dcb63e10bf")
