;;; lang/scad/config.el -*- lexical-binding: t; -*-

(setq org-babel-default-header-args:scad
  '((:results . "file")
    (:exports . "code")))

(when (and (modulep! +lsp) (modulep! :tools lsp +eglot))
  (after! eglot
    (add-to-list 'eglot-server-programs
                 '(scad-mode . ("openscad-lsp" "--stdio")))
    (add-to-list 'eglot-server-programs
                 '(scad-ts-mode . ("openscad-lsp" "--stdio")))))


(defun +scad-common-config (mode)
  (when (modulep! +lsp)
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append))
  (map! :localleader
        :map ,(intern (format "%s-map" mode))
        :desc "Export"  "e" #'scad-export
        :desc "Open"    "o" #'scad-open
        :desc "Preview" "p" #'scad-preview))


(use-package! scad-mode
  :defer t
  :init
  (when (modulep! +tree-sitter)
    (after! org-src
      (add-to-list 'org-src-lang-modes '("scad" . scad-ts-mode))))
  :config
  (+scad-common-config 'scad-mode)
  (add-to-list 'evil-emacs-state-modes 'scad-preview-mode)
  (map! :map scad-preview-mode-map
    :desc "Distance+"          "[" #'scad-preview-distance+
    :desc "Distance-"          "]" #'scad-preview-distance-
    :desc "Toggle Projection"  "p" #'scad-preview-projection
    :desc "Translate x-"       "h" #'scad-preview-translate-x-
    :desc "Translate x+"       "l" #'scad-preview-translate-x+
    :desc "Translate y-"       "j" #'scad-preview-translate-y-
    :desc "Translate y+"       "k" #'scad-preview-translate-y+
    :desc "Translate z-"       "n" #'scad-preview-translate-z-
    :desc "Translate z+"       "m" #'scad-preview-translate-z+
    :desc "Rotate x-"          "H" #'scad-preview-rotate-x-
    :desc "Rotate x+"          "L" #'scad-preview-rotate-x+
    :desc "Rotate y-"          "J" #'scad-preview-rotate-y-
    :desc "Rotate y+"          "K" #'scad-preview-rotate-y+
    :desc "Rotate z-"          "N" #'scad-preview-rotate-z-
    :desc "Rotate z+"          "M" #'scad-preview-rotate-z+))


(use-package! scad-ts-mode
  :when (modulep! +tree-sitter)
  :defer t
  :init
  (set-tree-sitter! 'scad-mode 'scad-ts-mode
    '((openscad :url "https://github.com/openscad/tree-sitter-openscad")))
  :config
  (+scad-common-config 'scad-ts-mode))
