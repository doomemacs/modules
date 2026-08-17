;; -*- no-byte-compile: t; -*-
;;; ui/ligatures/packages.el

(when (and (or (featurep 'ns)
               (string-match-p "HARFBUZZ" system-configuration-features))
           (featurep 'composite))
  (package! ligature :pin "e0bc07ec41203b72386a2b878b6c8a65c28f4ced"))
