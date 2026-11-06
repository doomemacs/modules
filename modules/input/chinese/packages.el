;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el

(package! pyim :pin "551517408f2803ecd096180e399c4f06f33ca156")
(package! fcitx :pin "b399482ed8db5893db2701df01db4c38cccda495")
(package! ace-pinyin :pin "47662c0b05775ba353464b44c0f1a037c85e746e")
(package! pangu-spacing :pin "72de84e999aafa753a635b14bb199fc46d322945")
(when (modulep! +rime)
  (package! liberime :pin "61997ed192afa3a107c4cfe70c28f145e7368388"))
(when (modulep! +childframe)
  (package! posframe :pin "1a6a25c58559ef43821a071c43b23de5cbc3cc3a"))
(when (modulep! :editor evil +everywhere)
  (package! evil-pinyin
    :recipe (:build (:not autoloads))
    :pin "0fae5ad8761417f027b33230382a50f826ad3bfb"))
