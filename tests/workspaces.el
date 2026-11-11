;;; workspaces.el --- :ui workspaces persistence tests -*- lexical-binding: t; -*-

;; Run with: emacs -Q --batch -L /path/to/persp-mode -l tests/workspaces.el

(require 'ert)
(require 'persp-mode)
(load-file (expand-file-name "../modules/ui/workspaces/autoload/workspaces.el"
                             (file-name-directory (or load-file-name buffer-file-name))))
(defvar +workspaces-data-file "_workspaces")

(defun workspaces-test--saved-file (file)
  (with-temp-buffer
    (insert-file-contents-literally file)
    (buffer-string)))

(defun workspaces-test--window-dimensions ()
  (sort (mapcar (lambda (window)
                  (cons (window-total-width window)
                        (window-total-height window)))
                (window-list))
        (lambda (a b)
          (if (= (car a) (car b))
              (< (cdr a) (cdr b))
            (< (car a) (car b))))))

(ert-deftest workspaces-save-captures-latest-layout ()
  (let ((persp-save-dir (make-temp-file "doom-workspaces-save-" t)))
    (unwind-protect
        (progn
          (persp-mode 1)
          (persp-add-new "test-layout")
          (persp-frame-switch "test-layout")
          (split-window-right)
          (should (+workspace-save "test-layout"))
          (select-window (next-window))
          (enlarge-window-horizontally 7)
          (split-window-below)
          (should (+workspace-save "test-layout"))
          (let* ((file (expand-file-name +workspaces-data-file persp-save-dir))
                 (entry (cl-find "test-layout" (persp-savelist-from-savefile file)
                                 :key #'cadr :test #'equal))
                 (state (cadr (assq 'def-wconf entry)))
                 (dimensions (workspaces-test--window-dimensions)))
            (should state)
            (delete-other-windows)
            (window-state-put state (frame-root-window) t)
            (should (= (length (window-list)) 3))
            (should (equal dimensions (workspaces-test--window-dimensions)))))
      (persp-mode -1)
      (delete-directory persp-save-dir t))))

(ert-deftest workspaces-load-does-not-autosave-over-snapshot ()
  (let* ((persp-save-dir (make-temp-file "doom-workspaces-load-" t))
         (file (expand-file-name +workspaces-data-file persp-save-dir))
         (persp-auto-save-fname "autosave")
         (persp-auto-save-persps-to-their-file t))
    (unwind-protect
        (progn
          (persp-mode 1)
          (persp-add-new "test-snapshot")
          (persp-frame-switch "test-snapshot")
          (split-window-right)
          (should (+workspace-save "test-snapshot"))
          (persp-add-new "test-other")
          (persp-frame-switch "test-other")
          (persp-kill "test-snapshot" t)
          (should (+workspace-load "test-snapshot"))
          (let ((snapshot (workspaces-test--saved-file file)))
            ;; A reduced layout (e.g. in a TTY) must not replace the snapshot.
            (setf (persp-window-conf (+workspace-get "test-snapshot")) nil)
            (persp-save-state-to-file "autosave")
            (should (equal snapshot (workspaces-test--saved-file file)))))
      (persp-mode -1)
      (delete-directory persp-save-dir t))))

(ert-deftest workspaces-tty-restores-gui-window-state ()
  (let* ((window (frame-root-window))
         (original (window-state-get window t)))
    (unwind-protect
        (progn
          (split-window-right)
          (split-window-below)
          (let* ((state (copy-tree (window-state-get (frame-root-window) t)))
                 (expected (length (window-list)))
                 (persp-window-state-put-function #'+workspaces-window-state-put))
            ;; Simulate pixel constraints from a GUI font in a TTY frame.
            (setcdr (assq 'pixel-height state) 1000)
            (setcdr (assq 'min-pixel-height-ignore (car state)) 200)
            (delete-other-windows)
            (funcall persp-window-state-put-function state (selected-frame))
            (should (= (length (window-list)) expected))))
      (delete-other-windows)
      (window-state-put original (frame-root-window) t))))

(ert-run-tests-batch-and-exit)
;;; workspaces.el ends here
