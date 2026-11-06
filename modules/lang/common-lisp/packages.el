;; -*- no-byte-compile: t; -*-
;;; lang/common-lisp/packages.el

(when (package! sly :pin "70350623eecd1f41837c9e57cbb6d5c06678a60d")
  (package! sly-asdf :pin "c1fa52dadb2f453243dc522203b7a883adef63fb")
  (package! sly-quicklisp :pin "34c73d43dd9066262387c626c17a9b486db07b2d")
  (package! sly-stepper :recipe (:host github :repo "joaotavora/sly-stepper"
                                 :files (:defaults "*.lisp" "*.asd")))
  (package! sly-macrostep :pin "5113e4e926cd752b1d0bcc1508b3ebad5def5fad")
  (package! sly-repl-ansi-color :pin "b9cd52d1cf927bf7e08582d46ab0bcf1d4fb5048")
  (package! sly-overlay :pin "345b554ad005421b447b2e64c34314ee79f5f8b9"))

(when (and (modulep! +tree-sitter)
           (treesit-available-p)
           (version<= "30.2" emacs-version))
  (package! lisp-ts-mode :pin "0a318b9ef97cc22d7827ad94d788104ad04e447b"))
