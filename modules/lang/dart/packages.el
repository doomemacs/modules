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
  (package! flutter :pin "e71235d400787d977da7ed792709437899c2a03c")
  (package! hover :pin "1b380fa3951d78a9a9eda28a4bcb5a3536a100b9"))
