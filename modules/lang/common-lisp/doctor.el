;;; lang/common-lisp/doctor.el -*- lexical-binding: t; -*-

(assert! (or (not (modulep! +tree-sitter))
             (modulep! :tools tree-sitter))
         "This module requires (:tools tree-sitter)")

(when (modulep! +tree-sitter)
  (when (< (treesit-library-abi-version) 15)
    (warn! "Tree-sitter library version is too old for the Common Lisp grammar."))
  (unless (version<= "30.2" emacs-version)
    (warn! "lisp-ts-mode requires Emacs 30.2 or newer.")))

(when (require 'sly nil t)
  (unless (executable-find
           (car (if (listp inferior-lisp-program)
                    inferior-lisp-program
                  (split-string inferior-lisp-program))))
    (warn! "Couldn't find your `inferior-lisp-program' (%s). Is it installed?"
           inferior-lisp-program)))
