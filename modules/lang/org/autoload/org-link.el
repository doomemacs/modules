;;; lang/org/autoload/org-link.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;
;;; * Link preview functions

;;;###autoload
(defun +org-link-preview-attachment-fn (ov link elem)
  "Preview images managed by org-download and org-attach in Org buffers."
  (let ((link
         (pcase (org-element-property :type elem)
           ("download"
            (expand-file-name
             link (or (if (require 'org-download nil t) org-download-image-dir)
                      default-directory)))
           ("attachment"
            (require 'org-attach)
            (org-attach-expand link))
           (_ (expand-file-name link default-directory)))))
    (when (and (file-readable-p link)
               (image-supported-file-p link))
      (org-link-preview-file ov link elem))))

;;;###autoload
(defun +org-link-preview-image-data-fn (ov data elem)
  "Preview base64 encoded images in Org buffers."
  (save-match-data
    (when-let*
        (((string-match "^image/\\([^;]+\\);base64,\\(.+\\)" data))
         (raw-data (base64-decode-string (match-string 2 data)))
         (type (or (image-type-from-data raw-data) (match-string 1 data)))
         (cache-file (doom-path
                      +org-preview-dir (format "imagedata.%s.%s"
                                               (sha1 data)
                                               type))))
      (unless (file-exists-p cache-file)
        (with-temp-file cache-file
          (insert raw-data)))
      (when (file-readable-p cache-file)
        (org-link-preview-file ov cache-file elem)))))

;;;###autoload
(defun +org-link-preview-image-url-fn (ov link elem)
  "Preview remote images (http/https links) in Org buffers."
  (when (and (image-supported-file-p link)
             (not (eq org-display-remote-inline-images 'skip)))
    (if-let* ((raw-link (org-element-property :raw-link elem))
              (buf (url-retrieve-synchronously raw-link))
              (cache-file (doom-path
                           +org-preview-dir (format "image.%s.%s"
                                                    (sha1 raw-link)
                                                    (file-name-extension link)))))
        (progn
          (unless (file-exists-p cache-file)
            (make-directory +org-preview-dir t)
            (with-temp-file cache-file
              (insert
               (with-current-buffer buf
                 (goto-char (point-min))
                 (re-search-forward "\r?\n\r?\n" nil t)
                 (buffer-substring-no-properties (point) (point-max))))))
          (when (file-readable-p cache-file)
            (org-link-preview-file ov cache-file elem)))
      (message "Download of image \"%s\" failed" link)
      nil)))


;;
;;; * Commands

;;;###autoload
(defun +org/remove-link ()
  "Unlink the text at point."
  (interactive)
  (unless (org-in-regexp org-link-bracket-re 1)
    (user-error "No link at point"))
  (save-excursion
    (let ((label (if (match-end 2)
                     (match-string-no-properties 2)
                   (org-link-unescape (match-string-no-properties 1)))))
      (delete-region (match-beginning 0) (match-end 0))
      (insert label))))

;;;###autoload
(defun +org/yank-link ()
  "Copy the url at point to the clipboard.
If on top of an Org link, will only copy the link component."
  (interactive)
  (let ((url (thing-at-point 'url)))
    (kill-new (or url (user-error "No URL at point")))
    (message "Copied link: %s" url)))

;;; org-link.el ends here
