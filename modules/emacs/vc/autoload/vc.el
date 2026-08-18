;;; emacs/vc/autoload/vc.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;
;;; * Helpers

(defun +vc--git-link (&optional arg)
  (require 'git-link)
  (dlet ((git-link-use-commit
          (if arg (not git-link-use-commit) git-link-use-commit)))
    (apply #'git-link
           (git-link--remote)
           (or (and (doom-region-active-p)
                    (git-link--get-region))
               (list nil nil)))))

(defun +vc--git-link-commit (&optional arg)
  (require 'git-link)
  (dlet ((git-link-use-commit
          (if arg (not git-link-use-commit) git-link-use-commit)))
    (git-link-commit (git-link--select-remote))))

(defun +vc--git-link-homepage ()
  (require 'git-link)
  (git-link-homepage (git-link--remote)))


;;
;;; * Commands

;;;###autoload
(defun +vc/git-link (&optional arg)
  "Open URL to current file (and line if selection is active) in browser.

Recognizes git-timemachine and various magit buffers.

If prefix ARG is given, do the opposite of the default setting of
`git-link-use-commit'."
  (interactive "P")
  (browse-url (or (if (derived-mode-p 'magit-mode)
                      (+vc--git-link-commit arg))
                  (+vc--git-link arg))))

;;;###autoload
(defun +vc/git-link-kill (&optional arg)
  "Copy URL to current file (and line if selection is active) to clipboard.

Recognizes git-timemachine and various magit buffers.

If prefix ARG is given, do the opposite of the default setting of
`git-link-use-commit'."
  (interactive "P")
  (let ((link (or (if (derived-mode-p 'magit-mode)
                      (+vc--git-link-commit arg))
                  (+vc--git-link arg))))
    (kill-new link)
    (message "Copied to clipboard: %s" link)))

;;;###autoload
(defun +vc/git-link-homepage ()
  "Open homepage for current project in browser."
  (interactive)
  (browse-url (+vc--git-link-homepage)))

;;;###autoload
(defun +vc/git-link-kill-homepage ()
  "Copy homepage URL of current project to clipboard."
  (interactive "P")
  (let ((link (+vc--git-link-homepage)))
    (kill-new link)
    (message "Copied to clipboard: %S" link)))

;;; vc.el ends here
