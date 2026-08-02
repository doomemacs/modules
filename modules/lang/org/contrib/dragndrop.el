;;; lang/org/contrib/dragndrop.el -*- lexical-binding: t; -*-
;;;###if (modulep! +dragndrop)

(use-package! org-download
  :commands
  org-download-dnd
  org-download-yank
  org-download-screenshot
  org-download-clipboard
  org-download-dnd-base64
  :init
  ;; HACK: We add these manually so that org-download is truly lazy-loaded
  (add-to-list 'dnd-protocol-alist '("^data:" . org-download-dnd-base64))
  (add-to-list 'dnd-protocol-alist '("^\\(?:https?\\|ftp\\|file\\|nfs\\):" . org-download-dnd))
  (advice-add #'org-download-enable :override #'ignore)

  (after! org
    ;; A shorter link to attachments
    (letf! (defun dir (&rest segments)
             (apply #'doom-path (or org-download-image-dir org-attach-id-dir ".")
                    segments))
      (org-link-set-parameters
       "download"
       :preview #'+org-link-preview-attachment-fn
       :complete (fn! (require 'org-download)
                      (let* ((root (dir))
                             (path (doom-docs--read-link-path key root))
                             (path* (file-relative-name path root)))
                        (if (string-match-p "\\.\\." path*) path path*)))
       :follow (fn! (org-link-open-as-file (dir %) nil))
       :face (fn! (let* ((path (dir %))
                         (option-index (string-match-p "::\\(.*\\)\\'" path))
                         (file-name (substring path 0 option-index)))
                    (if (file-exists-p file-name)
                        'org-link
                      'error))))))
  :config
  (unless org-download-image-dir
    (setq org-download-image-dir org-attach-id-dir))
  (setq org-download-method 'attach
        org-download-timestamp "_%Y%m%d_%H%M%S"
        org-download-screenshot-method
        (cond ((featurep :system 'macos) "screencapture -i %s")
              ((featurep :system 'linux)
               (cond ((executable-find "maim")  "maim -s %s")
                     ((executable-find "scrot") "scrot -s %s")
                     ((executable-find "gnome-screenshot") "gnome-screenshot -a -f %s"))))

        org-download-heading-lvl nil
        org-download-link-format "[[download:%s]]\n"
        org-download-annotate-function (lambda (_link) "")
        org-download-link-format-function
        (lambda (filename)
          (if (eq org-download-method 'attach)
              (format "[[attachment:%s]]\n"
                      (org-link-escape
                       (file-relative-name filename (org-attach-dir))))
            ;; Handle non-image files a little differently. Images should be
            ;; inserted as normal with previews. Other files, like pdfs or zips,
            ;; should be linked to, with an icon indicating the type of file.
            (format (concat (unless (image-supported-file-p filename)
                              (concat (+org-attach-icon-for filename)
                                      " "))
                            org-download-link-format)
                    (org-link-escape
                     (funcall org-download-abbreviate-filename-function filename)))))
        org-download-abbreviate-filename-function
        (lambda (path)
          (if (file-in-directory-p path org-download-image-dir)
              (file-relative-name path org-download-image-dir)
            path))))
