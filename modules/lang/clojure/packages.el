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
(package! parseclj :pin "ca828c202c026e45bd60503984cf510d904cae50")
(package! parseedn :pin "1a28a88e2aabd99b41e02f491d6b8874ec128d7d")

;;; Core packages
(package! clojure-mode :pin "3c68569738f04a22d52f1ca28f593c2ee733bf04")
(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (> emacs-major-version 29))  ; requires 30+
  (package! clojure-ts-mode :pin "ab0fac4282bf6426f4a5bce0fec7bf40d18b2e1a"))
(package! clj-refactor :pin "2805bd5f505fdb199a8c5a25fca398ec9c161e5b")
(package! cider :pin "501e1686962ce2613f7478b2a3a0f63c546b812e")
(when (modulep! :checkers syntax -flymake)
  (package! flycheck-clj-kondo :pin "414a3ead1faefb234d658fd8a8ba121c95b71de2"))
(package! jet :pin "c9a92675efd802f37df5e3eab7858dbbeced6ea4")
(package! neil
  :recipe (:host github :repo "babashka/neil" :files ("*.el"))
  :pin "ea7cd2ec2794c1c5e4a924e7579dde7356ffee50")
