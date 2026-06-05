;; -*- no-byte-compile: t; -*-
;;; lang/clojure/packages.el

;; HACK: Fix #5577. Paredit is a cider dependency. We install paredit ourselves
;;   to get it from emacsmirror, because the original upstream is a custom git
;;   server with shallow clones disabled.
(package! paredit
  :recipe (:host github :repo "emacsmirror/paredit")
  :pin "af075775af91f2dbc63b915d762b4aec092946c4")

;; HACK: Forward declare these clj-refactor/cider deps so that their deps are
;;   byte-compiled first.
(package! parseclj :pin "6af22372e0fe14df882dd300b22b12ba2d7e00b0")
(package! parseedn :pin "3407e4530a367b6c2b857dae261cdbb67a440aaa")

;;; Core packages
(package! clojure-mode :pin "c3b039ecf85e343edbc67c5856322654381dbc3e")
(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (> emacs-major-version 29))  ; requires 30+
  (package! clojure-ts-mode :pin "ba6de87b0acb5aa5483f6012611b30f6bf0414f3"))
(package! clj-refactor :pin "39c9688c79e1d00965621d04c04fe1ddde4b571f")
(package! cider :pin "e71110778a002e10a7c9763e0e6618a958d0ddb4")
(when (modulep! :checkers syntax -flymake)
  (package! flycheck-clj-kondo :pin "e38c67ba9db1ea1cbe1b61ab39b506c05efdcdbf"))
(package! jet :pin "c9a92675efd802f37df5e3eab7858dbbeced6ea4")
(package! neil
  :recipe (:host github :repo "babashka/neil" :files ("*.el"))
  :pin "f2b74b61c94fa668ab4517d4be3930cf64ebb446")
