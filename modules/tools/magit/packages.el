;; -*- no-byte-compile: t; -*-
;;; tools/magit/packages.el

;; REVIEW: This file contains pinned dependencies. This goes against our policy
;;   of only pinning primary packages, but an exception is made because the
;;   Magit ecosystem seems prone to breakage.

(package! transient :pin "0ec75dcce235f5ab3d39a02b878e6aaa78159b22") ; 0.13.7
(package! cond-let :pin "c48600dfab6372670225f046cace263700c78eab")  ; 1.1.3

(package! magit :pin "67f203853e74e926e2c99f60ed508840714f7ced")     ; 4.7.0
(when (modulep! +forge)
  (package! closql :pin "d382e7427f5d375ffc872851b049e9f9c4a43dfc")  ; 2.4.1
  (package! forge :pin "29f45d8f247079a1d8d2247efdacb5b50a3b1e51")   ; 0.6.8
  (package! ghub :pin "cba5666d8b999e2733aefac369a4e0def3be7fc9")    ; 5.3.0
  (package! code-review
    :recipe (:host github
             :repo "doomelpa/code-review"
             :files ("graphql" "code-review*.el"))
    :pin "303edcfbad8190eccb9a9269dfc58ed26d386ba5"))

(when (modulep! :lang org)
  (package! orgit :pin "c948819a7cad37a654ada275ebf7c003abf782d0") ; v2.2.1
  (when (modulep! :tools magit +forge)
    (package! orgit-forge :pin "87f257ba03c634198a634f0bdafc1b9cf6c6d09a"))) ; v1.1.4
