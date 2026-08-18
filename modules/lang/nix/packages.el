;; -*- no-byte-compile: t; -*-
;;; lang/nix/packages.el

(package! nix-mode :pin "2c77e7e0b7540efbb20ccaee3557ef90a5dc77f0")
(package! nix-update :pin "d67f4f7ba8c8ec43144600f5f970c5fd958fc2f7")
(package! nixos-options :pin "e241b58c9e6e24b9c2bdc708631db21a3ed2fe4b")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! nix-ts-mode :pin "09c89886a22b8e37ac0de9210ff5b2b79c520fd7"))

(when (modulep! :completion company)
  (package! company-nixos-options :pin "e241b58c9e6e24b9c2bdc708631db21a3ed2fe4b"))

(when (modulep! :completion helm)
  (package! helm-nixos-options :pin "e241b58c9e6e24b9c2bdc708631db21a3ed2fe4b"))
