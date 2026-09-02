;; -*- no-byte-compile: t; -*-
;;; completion/vertico/packages.el

(package! vertico :pin "cd2eb6daff6a5a68a11740aa363729ec6f8702d3")

(package! orderless :pin "51f677f464424ce3c46e3deacb7709784795a03b")

(package! consult :pin "3a2441ddb08d9897eb266cda4935fa91a767e1d5")
(package! consult-dir :pin "1497b46d6f48da2d884296a1297e5ace1e050eb5")
(when (modulep! :checkers syntax -flymake)
  (package! consult-flycheck :pin "087454a31b51ec007365f8e92a04e69409f294d3"))
(package! embark :pin "87e53827cf6659dcc4ac4e54be9af34aeca44f6e")
(package! embark-consult :pin "87e53827cf6659dcc4ac4e54be9af34aeca44f6e")

(package! marginalia :pin "d76d7e36185ab552240c14fb08f7abcbf9a2910c")

(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(when (modulep! +icons)
  (package! nerd-icons-completion :pin "45b585d972192a3eaeb239e15e55de7f46f8920a"))

(when (modulep! +childframe)
  (package! vertico-posframe
    :recipe (:host github :repo "tumashu/vertico-posframe")
    :pin "d6e06a4f1b34d24cc0ca6ec69d2d6c965191b23e"))

(when (modulep! :editor snippets)
  (package! consult-yasnippet :pin "89e39887c87e25d18861216a4d72e5d174f13751"))
