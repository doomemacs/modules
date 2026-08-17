;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el

(package! pyim :pin "a56c8d992c872addcfc295c409a7bae70d00af87")
(package! fcitx :pin "b399482ed8db5893db2701df01db4c38cccda495")
(package! ace-pinyin :pin "47662c0b05775ba353464b44c0f1a037c85e746e")
(package! pangu-spacing :pin "72de84e999aafa753a635b14bb199fc46d322945")
(when (modulep! +rime)
  (package! liberime :pin "24b0f2e9f535af305767f56a417532b8165eaea8"))
(when (modulep! +childframe)
  (package! posframe :pin "ec0ec37c0d6397422a07def499e87591ca037af7"))
(when (modulep! :editor evil +everywhere)
  (package! evil-pinyin
    :recipe (:build (:not autoloads))
    :pin "0fae5ad8761417f027b33230382a50f826ad3bfb"))
