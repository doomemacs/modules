;; -*- no-byte-compile: t; -*-
;;; tools/llm/packages.el

(package! gptel
  :recipe (:nonrecursive t)
  :pin "ec25a41fb8bebf5ea08341a9d8c70c0ee907ee23")

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
    :pin "db030ea033e9cce0db6457ba530d6f29e5d181f2"))
