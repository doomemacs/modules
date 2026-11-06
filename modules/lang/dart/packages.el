;; -*- no-byte-compile: t; -*-
;;; lang/dart/packages.el

(package! dart-mode :pin "ea9c2204f3e27b5419b9c5dba8b2078b22eb8461")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! dart-ts-mode
    :recipe (:host github
             :repo "50ways2sayhard/dart-ts-mode")
    :pin "e4a32507ace42953d882bb12f8def0935a424b66"))

(when (and (modulep! +lsp)
           (modulep! :tools lsp -eglot))
  (package! lsp-dart :pin "bf4ed15c9e9adb90ac796af7847127027f1a1702"))

(when (modulep! +flutter)
  (package! flutter :pin "13c0c7c604f67f32ec658f94a3c846ad6e718428")
  (package! hover :pin "1b380fa3951d78a9a9eda28a4bcb5a3536a100b9"))
