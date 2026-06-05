;; -*- no-byte-compile: t; -*-
;;; tools/magit/packages.el

;; HACK: Fixes magit/magit#5462. Remove when addressed upstream.
(defvar magit-auto-revert-mode nil)

;; REVIEW: This file contains pinned dependencies. This goes against our policy
;;   of only pinning primary packages, but an exception is made because the
;;   Magit ecosystem seems prone to breakage.

(package! transient :pin "1856230dc181f23dd15026b0ad21d8b299b034d1") ; 0.13.4
(package! cond-let :pin "21b9e9835756ff5cd1acb971cf9eb56fff671c8b") ; 1.1.2

(package! magit :pin "c800f79c2061621fde847f6a53129eca0e8da728") ; 4.5.0
(when (modulep! +forge)
  (package! closql :pin "d382e7427f5d375ffc872851b049e9f9c4a43dfc") ; 2.4.1
  (package! forge
    :pin "a8af709bc15e973804af776bba66b4205540bd73" ; 0.6.6
    ;; forge depends on ghub, which requires Emacs 29.1+
    :disable (version< emacs-version "29.1"))
  (package! ghub
    :pin "62d3582f1e395de1cf410af1f125dae56fe1dc4d" ; 5.2.1
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
  (package! orgit :pin "4a4c03ee40b0e2509b49303e151ee217edaf0da4") ; v2.1.3
  (when (modulep! :tools magit +forge)
    (package! orgit-forge :pin "8e4496d7f7f84fab3e36d10883386c02f43a67e7"))) ; v1.1.2
