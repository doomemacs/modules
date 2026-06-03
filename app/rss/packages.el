;; -*- no-byte-compile: t; -*-
;;; app/rss/packages.el

(package! elfeed :pin "3ab97952cb752631c9636b55852a7fb4682d0b6c")
(package! elfeed-goodies :pin "544ef42ead011d960a0ad1c1d34df5d222461a6b")
(when (modulep! +org)
  (package! elfeed-org :pin "34c0b4d758942822e01a5dbe66b236e49a960583"))
(when (modulep! +youtube)
  (package! elfeed-tube :pin "ae763194ad36942ccdbd9d59a40926a33bffd89b"))
