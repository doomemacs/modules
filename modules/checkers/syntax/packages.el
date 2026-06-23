;; -*- no-byte-compile: t; -*-
;;; checkers/syntax/packages.el

(unless (modulep! +flymake)
  (package! flycheck :pin "96f1852c7e352c969393e6e66176178177e933be")
  (package! flycheck-popup-tip :pin "ef86aad907f27ca076859d8d9416f4f7727619c6")
  (when (modulep! +childframe)
    (package! flycheck-posframe :pin "aeccb14e90ba25f45e1919b776777fc6ec95e251")))

(when (modulep! +flymake)
  (package! flymake :pin "672e657179adb5da1fd2302cdbe14b07e05518eb")
  (package! flymake-popon
    :recipe (:host github :repo "doomelpa/flymake-popon")
    :pin "99ea813346f3edef7220d8f4faeed2ec69af6060"))
