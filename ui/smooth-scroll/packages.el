;; -*- no-byte-compile: t; -*-
;;; ui/smooth-scroll/packages.el

(package! ultra-scroll
  :recipe (:host github :repo "jdtsmith/ultra-scroll")
  :pin "c6decf7754edda0aa7c5a775b7d6147490a8f464")

(when (modulep! +interpolate)
  (package! good-scroll :pin "a7ffd5c0e5935cebd545a0570f64949077f71ee3"))
