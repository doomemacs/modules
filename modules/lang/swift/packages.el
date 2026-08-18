;; -*- no-byte-compile: t; -*-
;;; lang/swift/packages.el

(package! swift-mode :pin "610b2c24433c11c30a39a6799af69b10cd3bec97")

(if (modulep! +lsp)
    (unless (modulep! :tools lsp +eglot)
      (package! lsp-sourcekit :pin "8d5dac4e18e6c39e34ce5504f93a6a876d8e12db"))
  (when (modulep! :completion company)
    (package! company-sourcekit :pin "a1860ad4dd3a542acd2fa0dfac2a388cbdf4af0c"))
  (when (modulep! :checkers syntax -flymake)
    (package! flycheck-swift :pin "4c5ad401252400a78da395fd56a71e67ff8c2761")))

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! swift-ts-mode :pin "17806f6f56f09c86c5e70af239bea4313aaaf0b8"))
