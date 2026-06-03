;; -*- no-byte-compile: t; -*-
;;; ui/smooth-scroll/packages.el

(package! ultra-scroll
  :recipe (:host github :repo "jdtsmith/ultra-scroll")
  :pin "f38653053b5c9bbe8dbcb6b2236ab8997fc2f9bb")

(when (modulep! +interpolate)
  (package! good-scroll :pin "a7ffd5c0e5935cebd545a0570f64949077f71ee3"))
