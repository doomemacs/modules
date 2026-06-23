;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "2c4f03158a3bf410d95c57851de284a1f88537ca")
(package! elfeed-goodies :pin "544ef42ead011d960a0ad1c1d34df5d222461a6b")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "ae763194ad36942ccdbd9d59a40926a33bffd89b"))
