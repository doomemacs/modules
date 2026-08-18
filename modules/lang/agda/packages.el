;; -*- no-byte-compile: t; -*-
;;; lang/agda/packages.el

(unless (modulep! +local)
  (package! agda-input
    :recipe (:host github :repo "agda/agda"
             :files ("src/data/emacs-mode/agda-input.el")
             :nonrecursive t)
    :pin "d8a73ff720197796fb64c7652202d33e7abb3eb6")

  (package! agda2-mode
    :recipe (:host github :repo "agda/agda"
             :files ("src/data/emacs-mode/*.el"
                     (:exclude "agda-input.el"))
             :nonrecursive t)
    :pin "d8a73ff720197796fb64c7652202d33e7abb3eb6"))
