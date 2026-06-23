;; -*- no-byte-compile: t; -*-
;;; editor/whitespace/packages.el

(when (modulep! +guess)
  (package! dtrt-indent :pin "4b71bf995b12966bbc350a32796b9a5f11d67fa6"))

(when (modulep! +trim)
  (package! ws-butler
    ;; REVIEW: emacsmirror/nongnu_elpa serves this package from a branch. To stop
    ;;   Straight from clobbering a single repo for multiple packages, we must be
    ;;   explicit to force it to clone it multiple times.
    :recipe (:host github
             :repo "emacsmirror/nongnu_elpa"
             :branch "elpa/ws-butler"
             :local-repo "ws-butler")
    :pin "67c49cfdf5a5a9f28792c500c8eb0017cfe74a3a"))
