;;; lang/fsharp/config.el -*- lexical-binding: t; -*-

(defun +fsharp-common-config (mode)
  (set-formatter! 'fantomas '("fantomas" "--stdin") :modes (list mode))
  (when (modulep! +lsp)
    (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! 'append)))


;;
;;; Packages

(use-package! fsharp-mode
  :defer t
  :config
  (+fsharp-common-config 'fsharp-mode)

  ;; REVIEW: Most of these can't be directly ported to fsharp-ts-mode, so...?
  (when (executable-find "dotnet")
    (setq inferior-fsharp-program "dotnet fsi --readline-"))
  (if (modulep! +lsp)
      (setq fsharp-ac-intellisense-enabled nil)
    (setq fsharp-ac-use-popup nil) ; Use a buffer for docs rather than a pop-up
    (set-lookup-handlers! 'fsharp-mode :async t :definition #'fsharp-ac/gotodefn-at-point)
    (set-company-backend! 'fsharp-mode 'fsharp-ac/company-backend))
  (set-repl-handler! 'fsharp-mode #'run-fsharp)
  (set-indent-vars! 'fsharp-mode '(fsharp-indent-offset fsharp-continuation-offset))
  (map! :localleader
        :map fsharp-mode-map
        "b" #'fsharp-ac/pop-gotodefn-stack ; Useful for re-tracing your steps
        "e" #'fsharp-eval-region
        "l" #'fsharp-load-buffer-file
        (:unless (modulep! +lsp)
         "q" #'fsharp-ac/stop-process
         "t" #'fsharp-ac/show-tooltip-at-point)))


(use-package! fsharp-ts-mode
  :when (modulep! +tree-sitter)
  :defer t
  :init
  (set-tree-sitter! 'fsharp-mode 'fsharp-ts-mode 'fsharp)
  :config
  (+fsharp-common-config 'fsharp-ts-mode))
