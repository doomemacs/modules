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
(package! evil-terminal-cursor-changer :pin "5557d7e5c011962a06663924a26ca36af1ad5f84")

(package! kkp :pin "f6e9f8166995591a3ac1f62c79deebe93865ac49")
