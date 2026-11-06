;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "4c962a423c9f3eef9472555fccecf268f9d380fe")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "35766b2b8fdce210ff51ecb226aee79e1f303d0c"))
