;; -*- no-byte-compile: t; -*-
;;; tools/llm/packages.el

(package! gptel
  :recipe (:nonrecursive t)
  :pin "ac4e1fe736f37cf6d3927cd3ebc26f54d383425a")

(package! gptel-quick
  :recipe (:host github :repo "karthink/gptel-quick")
  :pin "36fe296e016449433fa1213f4b89cb8dc7d4db5e")

(when (modulep! :tools magit)
  (package! gptel-magit
    ;; REVIEW: Revert to upstream if ragnard/gptel-magit#7 is merged.
    :recipe (:host github
             :repo "ArthurHeymans/gptel-magit")
    :pin "fc55c36d5b7d26104358021fe802cc338ddbdff4"))

(when (modulep! :lang org)
  (package! ob-gptel
    :recipe (:host github :repo "jwiegley/ob-gptel")
    :pin "4961120b7fc6bd2e2debd73f84cdef360188d3c7"))
