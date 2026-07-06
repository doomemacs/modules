;; -*- no-byte-compile: t; -*-
;;; tools/llm/packages.el

(package! gptel
  :recipe (:nonrecursive t)
  :pin "ebf0f3d8e9932e0ac6de82542220864cc17f6784")

(package! gptel-quick
  :recipe (:host github :repo "karthink/gptel-quick")
  :pin "36fe296e016449433fa1213f4b89cb8dc7d4db5e")

(when (modulep! :tools magit)
  (package! gptel-magit
    ;; REVIEW: Revert to upstream if ragnard/gptel-magit#7 is merged.
    :recipe (:host github
             :repo "ArthurHeymans/gptel-magit")
    :pin "7af14bd1af6375e5eb5955554fd569e5adfecfcd"))

(when (modulep! :lang org)
  (package! ob-gptel
    :recipe (:host github :repo "jwiegley/ob-gptel")
    :pin "71584eb30e8317cf36104cec78b6d53c4433cae7"))
