;;; lang/prisma/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +lsp))
             (modulep! :tools lsp))
         "This module requires (:tools lsp)")

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(unless (executable-find "prisma")
  (warn! "Couldn't find prisma CLI in your PATH."))

(when (and (modulep! +lsp)
           (modulep! :tools lsp))
  (unless (executable-find "prisma-language-server")
    (warn! "Couldn't find prisma-language-server. LSP will not work.")))
