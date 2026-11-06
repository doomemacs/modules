;; -*- no-byte-compile: t; -*-
;;; lang/coq/packages.el

(package! proof-general
  :pin "80af5c9829168f2229262b63f42cdd12b6797506"
  ;; REVIEW: Remove when ProofGeneral/PG#771 is fixed. Also see
  ;;   doomemacs/core#8169.
  :recipe (:build (:not autoloads)))
(package! company-coq :pin "1fc1d8f2d56e460b33c6d41a659488dce7b214f9")
