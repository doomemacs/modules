;; -*- no-byte-compile: t; -*-
;;; tools/magit/packages.el

;; REVIEW: This file contains pinned dependencies. This goes against our policy
;;   of only pinning primary packages, but an exception is made because the
;;   Magit ecosystem seems prone to breakage.

(package! transient :pin "3d20a780605f0a33d6360dc0a2ce9174c69a9a92") ; 0.13.5
(package! cond-let :pin "c48600dfab6372670225f046cace263700c78eab")  ; 1.1.3

(package! magit :pin "b6c512597fd66abe69883a058a2d13bcea76bf33")     ; 4.6.0
(when (modulep! +forge)
  (package! closql :pin "d382e7427f5d375ffc872851b049e9f9c4a43dfc")  ; 2.4.1
  (package! forge :pin "9628f76740aec9270e9fb31457ff4cb38d9f3f16")   ; 0.6.7
  (package! ghub :pin "59d0b9b33e780d6cff5131886904ff26033dd2e6")    ; 5.2.2
  (package! code-review
    :recipe (:host github
             :repo "doomelpa/code-review"
             :files ("graphql" "code-review*.el"))
    :pin "303edcfbad8190eccb9a9269dfc58ed26d386ba5"))

(when (modulep! :lang org)
  (package! orgit :pin "7c4827cd04953166f71eaec151ad1c50872fc680") ; v2.2.0
  (when (modulep! :tools magit +forge)
    (package! orgit-forge :pin "c421620af3fb38ab4654f745f51370471b65cf4e"))) ; v1.1.3
