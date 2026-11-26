;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; lang/rust/doctor.el

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp)")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(assert! (or (not (modulep! +tree-sitter))
             (fboundp 'rust-ts-mode))
         "Can't find `rust-ts-mode'; Emacs 29.1+ is required")

(unless (executable-find "rustc")
  (warn! "Couldn't find rustc binary"))

(unless (executable-find "cargo")
  (warn! "Couldn't find cargo binary"))

(when (modulep! +lsp)
  (when (require 'rustic nil t)
    (pcase rustic-lsp-server
      (`rust-analyzer
       (unless (executable-find "rust-analyzer")
         (warn! "Couldn't find rust analyzer (rust-analyzer)")))
      (`rls
       (unless (executable-find "rls")
         (warn! "Couldn't find rls"))))))
