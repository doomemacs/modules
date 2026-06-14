;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; lang/scad/doctor.el

(assert! (or (modulep! -lsp)
             (modulep! :tools lsp))
         "This module requires (:tools lsp)")

(assert! (or (modulep! -tree-sitter)
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(unless (executable-find "openscad")
  (warn! "Couldn't find openscad binary"))

(when (modulep! +lsp)
  (unless (executable-find "openscad-lsp")
    (warn! "Couldn't find openscad-lsp binary. Install from https://github.com/Leathong/openscad-LSP")))
