;; -*- no-byte-compile: t; -*-
;;; completion/vertico/packages.el

(package! vertico :pin "6028bd3d32c99c28e2b938e5e5393ec3508d2424")

(package! orderless :pin "09c90d93efce4fdac52edfe8b22591b773f3e607")

(package! consult :pin "540ad1e59ef80b1c8dd712cbbaae8957533ad02c")
(package! consult-dir :pin "1497b46d6f48da2d884296a1297e5ace1e050eb5")
(when (modulep! :checkers syntax -flymake)
  (package! consult-flycheck :pin "9dd95361669f87e14230376f4f93c6b9a222c497"))
(package! embark :pin "350ca86924c5027e80875943fba7b912a71e5791")
(package! embark-consult :pin "350ca86924c5027e80875943fba7b912a71e5791")

(package! marginalia :pin "feb66c02bbd88dba867cdd92b94fe24279ed578a")

(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(when (modulep! +icons)
  (package! nerd-icons-completion :pin "45b585d972192a3eaeb239e15e55de7f46f8920a"))

(when (modulep! +childframe)
  (package! vertico-posframe
    :recipe (:host github :repo "tumashu/vertico-posframe")
    :pin "d6e06a4f1b34d24cc0ca6ec69d2d6c965191b23e"))

(when (modulep! :editor snippets)
  (package! consult-yasnippet :pin "89e39887c87e25d18861216a4d72e5d174f13751"))
