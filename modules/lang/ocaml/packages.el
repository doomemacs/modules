;; -*- no-byte-compile: t; -*-
;;; lang/ocaml/packages.el

(package! tuareg :pin "696fdc59e3a35cc44cd1c2d0607d782e0f0c9e71")
(package! opam-switch-mode :pin "1069e56a662f23ea09d4e05611bdedeb99257012")
(package! ocp-indent :pin "573616ab0898b98632f7e1a69c9993db54acf505")
(package! dune
  :recipe (:host github :repo "emacsmirror/dune")
  :pin "deb6ac2281bbe81c35acec0b8f78b0f57694c25b")

(unless (modulep! +lsp)
  (package! merlin :pin "a46ee0b7abad3079ec9eccbfcc3dc1ce14d4ce61")
  (package! merlin-eldoc :pin "bf8edc63d85b35e4def352fa7ce4ea39f43e1fd8")
  (package! merlin-company :pin "a46ee0b7abad3079ec9eccbfcc3dc1ce14d4ce61")
  (when (modulep! :checkers syntax -flymake)
    (package! flycheck-ocaml :pin "e302792ba72ad57b262e1ab79799960d49a4278d")))

(when (modulep! :tools eval)
  (package! utop :pin "1d484405bf14ccb97e72b50859c185a8609675f9"))
