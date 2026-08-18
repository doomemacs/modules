;; -*- no-byte-compile: t; -*-
;;; lang/markdown/packages.el

(package! markdown-mode :pin "f441e8bc9951e73b12c61e9198658488dd8e86e1")
(package! markdown-toc :pin "ab4ba86e627ef83b7eec6706d66b81241c96f48c")

;; Required by `markdown-mode', or it will install it via package.el if it isn't
;; present when you call `markdown-edit-code-block'.
(package! edit-indirect :pin "82a28d8a85277cfe453af464603ea330eae41c05")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! markdown-ts-mode
    :built-in 'prefer  ; Emacs 31+ has a superior markdown-ts-mode
    :pin "801579b9b955f63673dd6dc9742c1fd5311b76c9"))

(when (modulep! +grip)
  (package! grip-mode :pin "c5b5c3017869c9692f368430f7687abe604eb2d0"))

(when (modulep! :editor evil +everywhere)
  (package! evil-markdown
    :recipe (:host github :repo "Somelauw/evil-markdown")
    :pin "8e6cc68af83914b2fa9fd3a3b8472573dbcef477"))
