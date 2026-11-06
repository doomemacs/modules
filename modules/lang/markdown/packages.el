;; -*- no-byte-compile: t; -*-
;;; lang/markdown/packages.el

(package! markdown-mode :pin "e2e2bc753b4330f85b6ea7e62cd0552e8ea47b76")
(package! markdown-toc :pin "ab4ba86e627ef83b7eec6706d66b81241c96f48c")

;; Required by `markdown-mode', or it will install it via package.el if it isn't
;; present when you call `markdown-edit-code-block'.
(package! edit-indirect :pin "82a28d8a85277cfe453af464603ea330eae41c05")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! markdown-ts-mode
    :built-in 'prefer  ; Emacs 31+ has a superior markdown-ts-mode
    :pin "801579b9b955f63673dd6dc9742c1fd5311b76c9"))

(when (modulep! +grip)
  (package! grip-mode :pin "70e3a6e8978a09dfd5d5d5ca675304f5c8993539"))

(when (modulep! :editor evil +everywhere)
  (package! evil-markdown
    :recipe (:host github :repo "Somelauw/evil-markdown")
    :pin "8e6cc68af83914b2fa9fd3a3b8472573dbcef477"))
