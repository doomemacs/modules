;;; lang/org/contrib/noter.el -*- lexical-binding: t; -*-
;;;###if (modulep! +noter)

(use-package! org-noter
  :defer t
  :preface
  ;; Allow the user to preempt this and set the document search path
  ;; If not set then use `org-directory'
  (defvar org-noter-notes-search-path nil)
  :config
  (unless org-noter-notes-search-path
    (setq org-noter-notes-search-path (list org-directory)))
  (setq org-noter-auto-save-last-location t
        org-noter-separate-notes-from-heading t)

  ;; HACK: `org-noter-doc-mode-map' is a plain minor mode map, so it loses to
  ;;   the normal state keys on the document's major mode map (e.g.
  ;;   evil-collection remaps i to `ignore' in `pdf-view-mode', and :tools pdf
  ;;   binds q to `kill-current-buffer').
  (when (modulep! :editor evil)
    (evil-define-minor-mode-key 'normal 'org-noter-doc-mode
      "i" #'org-noter-insert-note
      "q" #'org-noter-kill-session)))
