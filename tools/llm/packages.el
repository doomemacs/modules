;; -*- no-byte-compile: t; -*-
;;; tools/llm/packages.el

(package! gptel
  :recipe (:nonrecursive t)
  :pin "f342b3010f135ca4a38b02564b50b2d3e66554cf")

(package! gptel-quick
  :recipe (:host github :repo "karthink/gptel-quick")
  :pin "018ff2be8f860a1e8fe3966eec418ad635620c38")

(when (modulep! :tools magit)
  (package! gptel-magit
    ;; REVIEW: Revert to upstream if ragnard/gptel-magit#7 is merged.
    :recipe (:host github
             :repo "ArthurHeymans/gptel-magit")
    :pin "2af31e616f181ba6f2b2e6cb794ac09bb2dae219"))

(when (modulep! :lang org)
  (package! ob-gptel
    :recipe (:host github :repo "jwiegley/ob-gptel")
    :pin "71584eb30e8317cf36104cec78b6d53c4433cae7"))
