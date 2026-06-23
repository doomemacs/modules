;; -*- no-byte-compile: t; -*-
;;; os/tty/packages.el

(if (modulep! +osc)
    (package! clipetty
      :recipe (:host github :repo "spudlyo/clipetty")
      :pin "01b39044b9b65fa4ea7d3166f8b1ffab6f740362")
  ;; Despite its name, this works for macOS as well.
  (package! xclip :pin "9ab22517f3f2044e1c8c19be263da9803fbca26a"))

;; Despite the evil-* prefix, evil-terminal-cursor-changer does not depend on
;; evil (anymore).
(package! evil-terminal-cursor-changer :pin "fb824f657fb4325c1124f3e1b61f0de7ed062adf")

(package! kkp :pin "0b77ce2fb9eefbb07ffa906f8fe2df14450a9cfc")
