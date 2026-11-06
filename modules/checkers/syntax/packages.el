;; -*- no-byte-compile: t; -*-
;;; checkers/syntax/packages.el

(unless (modulep! +flymake)
  (package! flycheck :pin "37a67536f9801f2e7dbd1b4ebd43c78129db7740")
  (package! flycheck-popup-tip :pin "79a70cf1f3b7b8db4eeb7cec01f6dedc0a38cabb")
  (when (modulep! +childframe)
    (package! flycheck-posframe :pin "aeccb14e90ba25f45e1919b776777fc6ec95e251")))

(when (modulep! +flymake)
  (package! flymake :pin "16a98c1710c2d55448a3afe19efe636f220cb648")
  (package! flymake-popon
    :recipe (:host github :repo "doomelpa/flymake-popon")
    :pin "99ea813346f3edef7220d8f4faeed2ec69af6060"))
