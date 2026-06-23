;;; editor/parinfer/config.el -*- lexical-binding: t; -*-

(use-package! parinfer-rust-mode
  :when (bound-and-true-p module-file-suffix)
  :hook ((emacs-lisp-mode
          clojure-mode
          clojure-ts-mode
          scheme-mode
          lisp-mode
          racket-mode
          fennel-mode
          hy-mode
          dune-mode) . parinfer-rust-mode)
  :init
  (setq parinfer-rust-disable-troublesome-modes t)
  :config
  (map! :map parinfer-rust-mode-map
        :localleader
        "p" #'parinfer-rust-switch-mode
        "P" #'parinfer-rust-toggle-disable))
