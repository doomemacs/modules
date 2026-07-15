;;; modules/email/mu4e/+compat.el --- backwards/forwards compatibility -*- lexical-binding: t; -*-
;;; Commentary:
;;
;; mu4e is notorious for throwing backwards compatibility to the wind. We
;; install `mu4e-compat' to handle most incompatibilities, but it hasn't seen
;; updates in a couple years and doesn't handle breakages in newer versions of
;; mu4e, so I do that here. Much of its innards must be copied because
;; `mu4e-compat's design makes it difficult to advise or extend.
;;
;;; Code:

(defvar mu4e-compat--needlessly-breaking-renames-sofar nil)
(defvar mu4e-compat--needlessly-breaking-renames-future nil)

(defun mu4e-compat-define-aliases-backwards (&optional oldest)
  "Define backwards-compatible aliases, back to Mu4e version OLDEST.
OLDEST can be a \"MAJOR.MINOR\" version string, or unset, in which case
aliases will be defined for all older versions."
  (dolist (rename-set mu4e-compat--needlessly-breaking-renames-sofar)
    (let ((version (car rename-set)))
      (when (or (not oldest)
                (version<= oldest version))
        (dolist (rename (cdr rename-set))
          (let ((old (car rename))
                (new (cdr rename)))
            (cond
             ((fboundp new)
              (define-obsolete-function-alias old new version))
             ((facep (and (boundp new) (symbol-value new)))
              (define-obsolete-face-alias old new version))
             ((boundp new)
              (define-obsolete-variable-alias old new version)))))))))

(defun mu4e-compat-define-aliases-forwards (&optional newest)
  "Define forwards-compatible aliases, up to Mu4e version NEWEST.
NEWEST can be a \"MAJOR.MINOR\" version string, or unset, in which case
aliases will be defined for all newer versions."
  (dolist (rename-set mu4e-compat--needlessly-breaking-renames-future)
    (let ((version (car rename-set)))
      (when (or (not newest)
                (version<= version newest))
        (dolist (rename (cdr rename-set))
          (let ((old (car rename))
                (new (cdr rename)))
            (cond
             ((fboundp old)
              (defalias new old nil)
              (make-obsolete old new version))
             ((facep (and (boundp old) (symbol-value old)))
              (put new 'face-alias old)
              (put old 'obsolete-face (purecopy version)))
             ((boundp old)
              (defvaralias new old nil)
              (dolist (prop '(saved-value saved-variable-comment))
                (and (get old prop)
                     (null (get new prop))
                     (put new prop (get old prop))))
              (make-obsolete-variable old new version)))))))))


;;
;;; * Bootstrap

(pcase (seq-take (version-to-list mu4e-mu-version) 2)
  (`(1 0)  (load "mu4e-compat-1.0" t))
  (`(1 8)  (load "mu4e-compat-1.8" t))
  (`(1 10) (load "mu4e-compat-1.10" t))
  (`(1 12) (load "mu4e-compat-1.12" t))
  (`(1 14) (load! "compat/1.14")))

(mu4e-compat-define-aliases-backwards)
(mu4e-compat-define-aliases-forwards)

;; For pre-1.0 mu4e
(unless (boundp 'mu4e-headers-buffer-name)
  (defvar mu4e-headers-buffer-name "*mu4e-headers*"))

;; REVIEW: How much of this is necessary anymore with `mu4e-compat'?
(when (version< mu4e-mu-version "1.8")
  ;; Define aliases to maintain backwards compatibility. The list of suffixes
  ;; were obtained by comparing mu4e~ and mu4e-- functions in `obarray'.
  (dolist (transferable-suffix
           '("check-requirements" "contains-line-matching" "context-ask-user"
             "context-autoswitch" "default-handler" "get-folder" "get-log-buffer"
             "get-mail-process-filter" "guess-maildir" "key-val"
             "longest-of-maildirs-and-bookmarks" "maildirs-with-query"
             "main-action-str" "main-bookmarks" "main-maildirs" "main-menu"
             "main-queue-size" "main-redraw-buffer"
             "main-toggle-mail-sending-mode" "main-view" "main-view-queue"
             "main-view-real" "main-view-real-1" "mark-ask-target"
             "mark-check-target" "mark-clear" "mark-find-headers-buffer"
             "mark-get-dyn-target" "mark-get-markpair" "mark-get-move-target"
             "mark-in-context" "mark-initialize" "org-store-link-message"
             "org-store-link-query" "pong-handler" "read-char-choice"
             "read-patch-directory" "replace-first-line-matching"
             "request-contacts-maybe" "rfc822-phrase-type" "start" "stop"
             "temp-window" "update-contacts" "update-mail-and-index-real"
             "update-mail-mode" "update-sentinel-func" "view-gather-mime-parts"
             "view-open-file" "view-mime-part-to-temp-file"))
    (defalias (intern (concat "mu4e--" transferable-suffix))
      (intern (concat "mu4e~" transferable-suffix))
      "Alias to provide the API of mu4e 1.8 (mu4e~ ⟶ mu4e--).")
    (dolist (transferable-proc-suffixes
             '("add" "compose" "contacts" "eat-sexp-from-buf" "filter"
               "find" "index" "kill" "mkdir" "move" "ping" "remove"
               "sent" "sentinel" "start" "view"))
      (defalias (intern (concat "mu4e--server-" transferable-proc-suffixes))
        (intern (concat "mu4e~proc-" transferable-proc-suffixes))
        "Alias to provide the API of mu4e 1.8 (mu4e~proc ⟶ mu4e--server)."))
    (defalias 'mu4e-search-rerun #'mu4e-headers-rerun-search
      "Alias to provide the API of mu4e 1.8.")
    (defun mu4e (&optional background)
      "If mu4e is not running yet, start it.
Then, show the main window, unless BACKGROUND (prefix-argument)
is non-nil."
      (interactive "P")
      (mu4e--start (and (not background) #'mu4e--main-view))))
  (setq mu4e-view-show-addresses t
        mu4e-view-show-images t
        mu4e-view-image-max-width 800
        mu4e-view-use-gnus t))

;;; +compat.el ends here
