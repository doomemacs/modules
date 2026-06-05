;; -*- no-byte-compile: t; -*-
;;; email/mu4e/packages.el

(package! mu4e-compat
  :recipe (:host github :repo "tecosaur/mu4e-compat")
   :pin "a33345cb8ef83554f01510bbc8f5c7323713aa8d")
(when (modulep! +org)
  (package! org-msg :pin "7b45df759340f3e388e84f497052b7cf3a41698c"))
