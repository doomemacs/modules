;;; ui/dashboard/autoload.el -*- lexical-binding: t; -*-

(defun +dashboard--help-echo ()
  (when-let* ((btn (button-at (point)))
              (msg (button-get btn 'help-echo)))
    (message "%s" msg)))

;;;###autoload
(defun +dashboard/open (frame)
  "Switch to the dashboard in the current window, of the current FRAME."
  (interactive (list (selected-frame)))
  (with-selected-frame frame
    (switch-to-buffer (doom-fallback-buffer))
    (+dashboard-reload t)))

;;;###autoload
(defun +dashboard/push-button ()
  "Push a button, but record window state before doing so.

This way, the dashboard can restore the last selected button and the scroll
position of the dashboard window when the user returns to it later."
  (interactive)
  (set-window-parameter nil '+dashboard-last-window-start (window-start))
  (set-window-parameter nil '+dashboard-last-position (point))
  (call-interactively #'push-button))

;;;###autoload
(defun +dashboard/forward-button (n)
  "Like `forward-button', but don't wrap."
  (interactive "p")
  (forward-button n nil)
  (+dashboard--help-echo))

;;;###autoload
(defun +dashboard/backward-button (n)
  "Like `backward-button', but don't wrap."
  (interactive "p")
  (backward-button n nil)
  (+dashboard--help-echo))
