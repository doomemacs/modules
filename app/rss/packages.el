;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "8d721a2ee2dfd7a3e8b0b391432047c0003505fc")
(package! elfeed-goodies :pin "544ef42ead011d960a0ad1c1d34df5d222461a6b")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "2d7251d8363661f7bae3fd6b27ef88edc65d25ed"))
