;; -*- no-byte-compile: t; -*-
;;; tools/magit/packages.el

;; HACK: Fixes magit/magit#5462. Remove when addressed upstream.
(defvar magit-auto-revert-mode nil)

;; REVIEW: This file contains pinned dependencies. This goes against our policy
;;   of only pinning primary packages, but an exception is made because the
;;   Magit ecosystem seems prone to breakage.

(package! transient :pin "9e78954343613786cdb0659183b766099f051149") ; 0.13.3
(package! cond-let :pin "7ec5ace3e6acc240179bf3cdeb6f9e6751530c38") ; 1.1.0

(package! magit :pin "c800f79c2061621fde847f6a53129eca0e8da728") ; 4.5.0
(when (modulep! +forge)
  (package! closql :pin "947426d0c93e5ad5374c464b2f121c36cdaf2132") ; 2.4.0
  (package! forge
    :pin "d4eb8d1be55398e350c8a68b0c355f5166418843" ; 0.6.5
    ;; forge depends on ghub, which requires Emacs 29.1+
    :disable (version< emacs-version "29.1"))
  (package! ghub
    :pin "c438abc865964554d0ee0b2d1a7def60de47a224" ; 5.2.0
    ;; ghub requires Emacs 29.1+
    :disable (version< emacs-version "29.1"))
  (package! code-review
    :recipe (:host github
             :repo "doomelpa/code-review"
             :files ("graphql" "code-review*.el"))
    :pin "303edcfbad8190eccb9a9269dfc58ed26d386ba5"
    ;; ...code-review depends on forge
    :disable (version< emacs-version "29.1")))

(when (modulep! :lang org)
  (package! orgit :pin "4fb91faff3bf32dac5f6f932654c280cd1f190f7") ; v2.1.2
  (when (modulep! :tools magit +forge)
    (package! orgit-forge :pin "8e4496d7f7f84fab3e36d10883386c02f43a67e7"))) ; v1.1.2
