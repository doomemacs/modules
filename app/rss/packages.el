;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "aad8d96818d5a68136fbd534897bedaf65122f32")
(package! elfeed-goodies :pin "544ef42ead011d960a0ad1c1d34df5d222461a6b")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "8e1334cfc8114ddd71b4de99760429e4e8a81f7b"))
