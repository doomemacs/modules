;; -*- no-byte-compile: t; -*-
;;; tools/magit/packages.el

;; REVIEW: This file contains pinned dependencies. This goes against our policy
;;   of only pinning primary packages, but an exception is made because the
;;   Magit ecosystem seems prone to breakage.

(package! transient :pin "0cacc84ff0c7df126e194666ff8b8a1e6082e796") ; 0.13.8
(package! cond-let :pin "09292a77001434f59ab55c775dec2b98cb18d028")  ; 1.1.5

(package! magit :pin "659f89955cf60fe3d4326d881c412df06c69680d")     ; 4.7.1
(when (modulep! +forge)
  (package! closql :pin "48955ae02cfc7dad93b6bdc9ffd8d4b760dfb62b")  ; 2.4.2
  (package! forge :pin "7dc4855437315cb932cbc1d6a903f7d2de03ec5f")   ; 0.6.9
  (package! ghub :pin "01e2bc064ab4965d332efa11fafeda2a43f338d1")    ; 5.3.3
  (package! code-review
    :recipe (:host github
             :repo "doomelpa/code-review"
             :files ("graphql" "code-review*.el"))
    :pin "303edcfbad8190eccb9a9269dfc58ed26d386ba5"))

(when (modulep! :lang org)
  (package! orgit :pin "5e5110393e73513571a55e8ca93894dd4629bc00") ; v2.2.2
  (when (modulep! :tools magit +forge)
    (package! orgit-forge :pin "8b5fbe9bb7dee123054bf9aa3095607e56e946cd"))) ; v1.1.5
