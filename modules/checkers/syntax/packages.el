;; -*- no-byte-compile: t; -*-
;;; checkers/syntax/packages.el

(unless (modulep! +flymake)
  (package! flycheck :pin "bed4c3b735d7a6285e3ed6ee1012007ae590c663")
  (package! flycheck-popup-tip :pin "79a70cf1f3b7b8db4eeb7cec01f6dedc0a38cabb")
  (when (modulep! +childframe)
    (package! flycheck-posframe :pin "aeccb14e90ba25f45e1919b776777fc6ec95e251")))

(when (modulep! +flymake)
  (package! flymake :pin "7edbb3639d05f26806037f7b0a24916d33d6d6a4")
  (package! flymake-popon
    :recipe (:host github :repo "doomelpa/flymake-popon")
    :pin "99ea813346f3edef7220d8f4faeed2ec69af6060"))
