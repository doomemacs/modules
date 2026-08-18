;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "943a5acf49b286a129a78f7142672126781578c0")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "f653d5b7f27a2eace217d9e6b4f40e0e35ae88cd"))
