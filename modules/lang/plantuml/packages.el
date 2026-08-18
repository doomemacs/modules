;; -*- no-byte-compile: t; -*-
;;; lang/plantuml/packages.el

(package! plantuml-mode :pin "a4a63efa4a3980bfbd825bfb3a263c6664401e79")
(when (modulep! :checkers syntax)
  (package! flycheck-plantuml :pin "183be89e1dbba0b38237dd198dff600e0790309d"))

;; ob-plantuml is provided by org-plus-contrib
