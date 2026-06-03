;; -*- no-byte-compile: t; -*-
;;; input/chinese/packages.el

(package! pyim :pin "a56c8d992c872addcfc295c409a7bae70d00af87")
(package! fcitx :pin "b399482ed8db5893db2701df01db4c38cccda495")
(package! ace-pinyin :pin "47662c0b05775ba353464b44c0f1a037c85e746e")
(package! pangu-spacing :pin "6509df9c90bbdb9321a756f7ea15bb2b60ed2530")
(when (modulep! +rime)
  (package! liberime :pin "482b7854b04169b348f3c943891f0895bd38bc4f"))
(when (modulep! +childframe)
  (package! posframe :pin "74c8c56131ed866db47ae4191364b72dd4852456"))
(when (modulep! :editor evil +everywhere)
  (package! evil-pinyin
    :recipe (:build (:not autoloads))
    :pin "0fae5ad8761417f027b33230382a50f826ad3bfb"))
