;; -*- no-byte-compile: t; -*-
;;; lang/rest/packages.el

(package! restclient :pin "d280632df39a175dac06037038105e32945624be")
(when (modulep! :completion company)
  (package! company-restclient :pin "e5a3ec54edb44776738c13e13e34c85b3085277b"))

(when (modulep! +jq)
  (package! jq-mode :pin "558f2af06c34f12c52097f8db746169c28c35484")
  (package! restclient-jq :pin "d280632df39a175dac06037038105e32945624be"))
