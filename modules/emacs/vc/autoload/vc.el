;;; emacs/vc/autoload/vc.el -*- lexical-binding: t; -*-

;;
;;; Helpers


;;
;;; Commands

;;;###autoload
(defun +vc/git-link ()
  "Open URL to current file (and line if selection is active) in browser."
  (interactive)
  (require 'magit)
  (if (region-active-p)
      (browse-url (git-link (magit-get-remote) (line-number-at-pos (region-beginning) ) (line-number-at-pos (region-end))))
    (browse-url (git-link (magit-get-remote) nil nil))))

;;;###autoload
(defun +vc/git-link-kill ()
  "Open URL to current file (and line if selection is active) in browser."
  (interactive)
  (require 'magit)
  (if (region-active-p)
      (kill-new (git-link (magit-get-remote) (line-number-at-pos (region-beginning)) (line-number-at-pos (region-end))))
    (kill-new (git-link (magit-get-remote) nil nil))))

;;;###autoload
(defun +vc/git-link-homepage ()
  "Open homepage for current project in browser."
  (interactive)
  (require 'magit)
  (browse-url (git-link-homepage (magit-get-remote))))

;;;###autoload
(defun +vc/git-link-kill-homepage ()
  "Copy homepage URL of current project to clipboard."
  (interactive)
  (require 'magit)
  (kill-new (git-link-homepage (magit-get-remote))))
