;;; app/everywhere/cli.el -*- lexical-binding: t; no-byte-compile: t -*-

(defcli! () ()
  "Spawn an emacsclient window for quick edits."
  (exit! "emacsclient --eval '(emacs-everywhere)'"))
