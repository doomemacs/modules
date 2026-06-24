;;; app/emms/config.el -*- lexical-binding: t; -*-

(use-package! emms
  :defer t
  :init
  (setq emms-directory (doom-profile-data-dir t "emms")
        emms-cache-file (doom-profile-cache-dir t "emms"))
  :config
  (emms-all)
  (emms-default-players)
  (map! :map emms-playlist-mode-map
        :localleader
        "l" #'emms-toggle-repeat-playlist
        "p" #'emms-insert-playlist
        "i" #'emms-insert-file
        "t" #'emms-toggle-repeat-track
        "s" #'emms-playlist-save
        "m" #'emms-shuffle))
