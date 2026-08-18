;; -*- no-byte-compile: t; -*-
;;; lang/coq/packages.el

(package! proof-general
  :pin "38e3f59d4b650fbfb9649c84f24adbc9056ffa30"
  ;; REVIEW: Remove when ProofGeneral/PG#771 is fixed. Also see
  ;;   doomemacs/core#8169.
  :recipe (:build (:not autoloads)))
(package! company-coq :pin "1fc1d8f2d56e460b33c6d41a659488dce7b214f9")
