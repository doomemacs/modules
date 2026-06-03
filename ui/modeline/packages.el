;; -*- no-byte-compile: t; -*-
;;; ui/modeline/packages.el

(unless (modulep! +light)
  (package! doom-modeline :pin "0b660ed93a185c3edaf8d11c550b15cfeb348a69"))
(package! anzu :pin "21cb5ab2295614372cb9f1a21429381e49a6255f")
(when (modulep! :editor evil)
  (package! evil-anzu :pin "7309650425797420944075c9c1556c7c1ff960b3"))
