;; -*- no-byte-compile: t; -*-
;;; completion/vertico/packages.el

(package! vertico :pin "c60d80215d19b4b36c0ba49599b6815ed35f2ac1")

(package! orderless :pin "e271a8ec938929b726331236cf56d1c44571122e")

(package! consult :pin "a64569f377b8bc0f62e1d2ae0f3ee48ba4a7cc1c")
(package! consult-dir :pin "1497b46d6f48da2d884296a1297e5ace1e050eb5")
(when (modulep! :checkers syntax -flymake)
  (package! consult-flycheck :pin "087454a31b51ec007365f8e92a04e69409f294d3"))
(package! embark :pin "87e53827cf6659dcc4ac4e54be9af34aeca44f6e")
(package! embark-consult :pin "87e53827cf6659dcc4ac4e54be9af34aeca44f6e")

(package! marginalia :pin "381af583d2530796b9955ff2fe0cba3ad3119943")

(package! wgrep :pin "49f09ab9b706d2312cab1199e1eeb1bcd3f27f6f")

(when (modulep! +icons)
  (package! nerd-icons-completion :pin "f924dd490c8c4c1066fd97a76e0dc31e303fca30"))

(when (modulep! +childframe)
  (package! vertico-posframe
    :recipe (:host github :repo "tumashu/vertico-posframe")
    :pin "bc0d9caf16ecf48605a3f156b8cc559c51959b15"))

(when (modulep! :editor snippets)
  (package! consult-yasnippet :pin "89e39887c87e25d18861216a4d72e5d174f13751"))
