;; -*- no-byte-compile: t; -*-
;;; completion/vertico/packages.el

(package! vertico :pin "9e09fdddd6d3d995173cae0904347f46c2cdc55d")

(package! orderless :pin "a5e960f5a9a080d982aba86378da1d12641cae5c")

(package! consult :pin "8ffa37d7cb577fab68ab580889412b9363235a05")
(package! consult-dir :pin "1497b46d6f48da2d884296a1297e5ace1e050eb5")
(when (modulep! :checkers syntax -flymake)
  (package! consult-flycheck :pin "16fa53d2cc31a2689dfb5d012575c81399f6669d"))
(package! embark :pin "ec5dd1475595277ef908567d0a18d32f1c40bc91")
(package! embark-consult :pin "ec5dd1475595277ef908567d0a18d32f1c40bc91")

(package! marginalia :pin "8d87d2aedcefe0b157204f5c936dce3d0eacdf27")

(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(when (modulep! +icons)
  (package! nerd-icons-completion :pin "45b585d972192a3eaeb239e15e55de7f46f8920a"))

(when (modulep! +childframe)
  (package! vertico-posframe
    :recipe (:host github :repo "tumashu/vertico-posframe")
    :pin "d6e06a4f1b34d24cc0ca6ec69d2d6c965191b23e"))

(when (modulep! :editor snippets)
  (package! consult-yasnippet :pin "a3482dfbdcbe487ba5ff934a1bb6047066ff2194"))
