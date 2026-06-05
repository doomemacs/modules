;;; lang/org/contrib/pretty.el -*- lexical-binding: t; -*-
;;;###if (modulep! +pretty)
(after! org
  (setq org-highlight-latex-and-related '(native script entities)))


(use-package! org-appear
  :hook (org-mode . org-appear-mode))


(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :hook (org-agenda-finalize . org-modern-agenda)
  :init
  (after! org
    (setq org-hide-emphasis-markers t
          org-pretty-entities t))
  :config
  ;; HACK: The default unicode symbol for checked boxes often turn out much
  ;;   larger than the others, so I swap it out with one that's more likely to
  ;;   be consistent.
  (setf (alist-get ?X org-modern-checkbox) #("□x" 0 2 (composition ((2)))))

  ;; Carry over the default values of `org-todo-keyword-faces', `org-tag-faces',
  ;; and `org-priority-faces' as reasonably as possible, but only if the user
  ;; hasn't already modified them.
  (letf! (defun new-spec (spec)
           (if (or (facep (cdr spec))
                   (not (keywordp (car-safe (cdr spec)))))
               `(:inherit ,(cdr spec))
             (cdr spec)))
    (unless org-modern-tag-faces
      (dolist (spec org-tag-faces)
        (add-to-list 'org-modern-tag-faces `(,(car spec) :inverse-video t ,@(new-spec spec)))))
    (unless org-modern-todo-faces
      (dolist (spec org-todo-keyword-faces)
        (add-to-list 'org-modern-todo-faces `(,(car spec) :inverse-video t ,@(new-spec spec)))))
    (unless org-modern-priority-faces
      (dolist (spec org-priority-faces)
        (add-to-list 'org-modern-priority-faces `(,(car spec) :inverse-video t ,@(new-spec spec)))))))
