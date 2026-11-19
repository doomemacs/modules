;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; lang/javascript/doctor.el

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp)")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(when (modulep! +lsp)
  (unless (executable-find "typescript-language-server")
    (warn! "Couldn't find typescript-language-server. %s"
           (if (modulep! :tools lsp +eglot)
               "LSP support won't work until it is installed"
             "lsp-mode will offer to install it for you, otherwise LSP support won't work"))))

(unless (modulep! +tree-sitter)
  (warn! "Typescript support is degraded without +tree-sitter (and Emacs 29+)")
  (warn! "No JSX/TSX support without +tree-sitter (and Emacs 29+)"))
