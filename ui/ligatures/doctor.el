;; This cond expression mimics the activation conditional of ligatures,
;; with a fallback that triggers a warning.
(cond
 ((if (featurep :system 'macos)
      (fboundp 'mac-auto-operator-composition-mode))
  (ignore))

 ((and (or (featurep 'ns)
           (string-match-p "HARFBUZZ" system-configuration-features))
       (featurep 'composite))           ; Emacs loads `composite' at startup
  (ignore))

 ((error! "Emacs was not built with Harfbuzz; ligatures won't work!")))
