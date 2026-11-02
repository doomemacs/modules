;;; term/ghostel/autoload.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

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
  (dlet ((default-directory (or (doom-project-root) default-directory)))
    (dlet ((ghostel-buffer-name (+ghostel--buffer-name "doom:" "-popup" t))
           ghostel-buffer-name-function
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
        (with-current-buffer (ghostel)
          ;; Don't rename the buffer or the popup manager may lose track of it.
          (setq-local ghostel-buffer-name-function nil)
          (set-window-dedicated-p (get-buffer-window) t)
          (current-buffer))))))

;;;###autoload
(defun +ghostel/here (arg)
  "Open a terminal buffer in the current window at project root.

If prefix ARG is non-nil, cd into `default-directory' instead of project root.

Returns the ghostel buffer."
  (interactive "P")
  (let* ((project-root (or (doom-project-root) default-directory))
         (default-directory
          (if arg default-directory project-root)))
    ;; we call ghostel with a non-numeric arg here
    ;; so that it always creates a new terminal
    ;; (by default it will merely bring up an existing
    ;;  terminal)
    (ghostel "new-terminal")))

;;; autoload.el ends here
