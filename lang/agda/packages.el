;; -*- no-byte-compile: t; -*-
;;; lang/agda/packages.el

(unless (modulep! +local)
  (package! agda-input
    :recipe (:host github :repo "agda/agda"
             :files ("src/data/emacs-mode/agda-input.el")
             :nonrecursive t)
    :pin "92b09bb0a7abeb6c591a132c27097b30044a6c0c")

  (package! agda2-mode
    :recipe (:host github :repo "agda/agda"
             :files ("src/data/emacs-mode/*.el"
                     (:exclude "agda-input.el"))
             :nonrecursive t)
    :pin "92b09bb0a7abeb6c591a132c27097b30044a6c0c"))
