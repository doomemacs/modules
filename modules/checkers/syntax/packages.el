;; -*- no-byte-compile: t; -*-
;;; checkers/syntax/packages.el

(unless (modulep! +flymake)
  (package! flycheck :pin "0e5eb8300d32fd562724216c19eaf199ee1451ab")
  (package! flycheck-popup-tip :pin "ef86aad907f27ca076859d8d9416f4f7727619c6")
  (when (modulep! +childframe)
    (package! flycheck-posframe :pin "aeccb14e90ba25f45e1919b776777fc6ec95e251")))

(when (modulep! +flymake)
  (package! flymake :pin "2418910539aa26a74ac55938a60f0d6a23a62dbd")
  (package! flymake-popon
    :recipe (:host github :repo "doomelpa/flymake-popon")
    :pin "99ea813346f3edef7220d8f4faeed2ec69af6060"))
