;; -*- no-byte-compile: t; -*-
;;; lang/ocaml/packages.el

(package! tuareg :pin "696fdc59e3a35cc44cd1c2d0607d782e0f0c9e71")
(package! opam-switch-mode :pin "1069e56a662f23ea09d4e05611bdedeb99257012")
(package! ocp-indent :pin "4044209c45fccd81b2e78333eebc9aeda04d6fbe")
(package! dune
  :recipe (:host github :repo "ocaml/dune" :files ("editor-integration/emacs/*.el"))
  :pin "19325e58d58ddc47b1ec9666288792a6c0574f1a")

(unless (modulep! +lsp)
  (package! merlin :pin "a46ee0b7abad3079ec9eccbfcc3dc1ce14d4ce61")
  (package! merlin-eldoc :pin "bf8edc63d85b35e4def352fa7ce4ea39f43e1fd8")
  (package! merlin-company :pin "a46ee0b7abad3079ec9eccbfcc3dc1ce14d4ce61")
  (when (modulep! :checkers syntax -flymake)
    (package! flycheck-ocaml :pin "e302792ba72ad57b262e1ab79799960d49a4278d")))

(when (modulep! :tools eval)
  (package! utop :pin "45a7f791a0afaacb36125f9733fd32ad9ad28181"))
