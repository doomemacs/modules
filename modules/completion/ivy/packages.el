;; -*- no-byte-compile: t; -*-
;;; completion/ivy/packages.el

(package! swiper :pin "7b267e29cd47b2036eafbc212683a721bd2b7dd0")
(package! ivy)
(package! ivy-avy)
(package! counsel)

(package! amx :pin "5b3aa1aae84f4a225cb8d26ab79a32f97693f023")
;; REVIEW: Frozen because later commits requires projectile >=3.3.0, and
;;   projectile is slated for removal from Doom core soon.
(package! counsel-projectile :pin "b7cc7e4e9daca5713ab2021deac2ffd68b389b12" :freeze t)
(package! ivy-rich :pin "aff9b6bd53e0fdcf350ab83c90e64e651b47dba4")
(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(if (modulep! +prescient)
    (package! ivy-prescient :pin "ae52777d6b6b856b54c85441c7a713949f1720de")
  (when (modulep! +fuzzy)
    (package! flx :pin "be738f439fa779c5a5def44569202d2d7c6b0547")))

(when (modulep! +childframe)
  (package! ivy-posframe :pin "ede7b2121f176ab543ce6b73fd96e3eafd6d1505"))

(when (modulep! +icons)
  (package! nerd-icons-ivy-rich :pin "5e48ac70294b3f78bf966bb30448130396daa937"))
