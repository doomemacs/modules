;;; lang/common-lisp/doctor.el -*- lexical-binding: t; -*-

(when (require 'sly nil t)
  (unless (executable-find
           (car (if (listp inferior-lisp-program)
                    inferior-lisp-program
                  (split-string inferior-lisp-program))))
    (warn! "Couldn't find your `inferior-lisp-program' (%s). Is it installed?"
           inferior-lisp-program)))

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(and (modulep! +tree-sitter)
     (< (treesit-library-abi-version) 15)
     (warn! "Tree-sitter library version is too old for the Common Lisp grammar."))
