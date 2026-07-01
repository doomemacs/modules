;;; term/ghostel/autoload.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defvar ghostel-buffer-name)

(defun +ghostel--buffer-name (&optional prefix suffix project?)
  (format "*%sghostel%s%s<%s>*"
          (or prefix "")
          (or suffix "")
          (if project?
              (concat
               ":" (or (doom-project-name)
                       (file-name-nondirectory
                        (directory-file-name default-directory))))
            "")
          (if (bound-and-true-p persp-mode)
              (safe-persp-name (get-current-persp))
            "main")))

;;;###autoload
(defun +ghostel/toggle (&optional arg)
  "Toggle a persistent terminal popup window at project root.

If prefix ARG is non-nil, recreate the ghostel buffer in the current project's
root.

Returns the ghostel buffer."
  (interactive "P")
  (let* ((default-directory (or (doom-project-root) default-directory))
         (ghostel-buffer-name (+ghostel--buffer-name "doom:" "-popup" t))
         confirm-kill-processes
         current-prefix-arg)
    (when arg
      (let ((buffer (get-buffer buffer-name))
            (window (get-buffer-window buffer-name)))
        (when (buffer-live-p buffer)
          (kill-buffer buffer))
        (when (window-live-p window)
          (delete-window window))))
    (if-let* ((win (get-buffer-window ghostel-buffer-name)))
        (delete-window win)
      (ghostel))))

;;;###autoload
(defun +ghostel/here ()
  "Open a new ghostel buffer in the current window."
  (interactive)
  (let ((ghostel-buffer-name
         (generate-new-buffer-name (+ghostel--buffer-name))))
    (switch-to-buffer (save-window-excursion (ghostel)))))

;;; autoload.el ends here
