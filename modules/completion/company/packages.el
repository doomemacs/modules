;; -*- no-byte-compile: t; -*-
;;; completion/company/packages.el

(package! company :pin "0029cbb435c7fc68ceff0987fae0256f1ccf0507")
(package! company-dict :pin "cd7b8394f6014c57897f65d335d6b2bd65dab1f4")
(when (modulep! +childframe)
  (package! company-box :pin "c4f2e243fba03c11e46b1600b124e036f2be7691"))
