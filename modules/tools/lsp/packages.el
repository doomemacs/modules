;; -*- no-byte-compile: t; -*-
;;; tools/lsp/packages.el

(if (modulep! +eglot)
    (progn
      (package! eglot :pin "e21a9a3ed7ecf3280e8adb927d986642f5ce382a")
      (package! jsonrpc :pin "1a6e75547ea866d525faf1b36bc005702cd4de71")
      (package! xref :pin "f8a7db5c8e85aa1c4c4fc8afa35ed50afac86f20")  ; needed by eglot
      (package! refactor :pin "0a862099d44b87a394f6d5a08388ce91e28cf4d4")  ; needed by eglot
      (when (modulep! :completion vertico)
        (package! consult-eglot :pin "3e4d9a40911b897c0a2c5d20199d0f7c30bfc1c2"))
      ;; DEPRECATED: Remove when 29 support is dropped
      (when (and (< emacs-major-version 30) (modulep! +booster))
        (package! eglot-booster
          :recipe (:host github :repo "jdtsmith/eglot-booster")
          :pin "510f579409627c333ef0e9157db713b1004da842")))

  ;; lsp-mode must be rebuilt if this variable is changed, so expose it here so
  ;; users can change it from $DOOMDIR/packages.el.
  (eval-and-compile (defvar lsp-use-plists t))

  (package! lsp-mode
    :pin "aebc8755d1cf6667382799e5168a67b6a6289a27"
    :env `(("LSP_USE_PLISTS" . ,(and lsp-use-plists "1"))))
  (package! lsp-ui :pin "176eca71d1c5498ed6258b5b27d73293ff7cd7ed")
  (when (modulep! :completion ivy)
    (package! lsp-ivy :pin "b061ff4afdcf3bac606fb46be84d67b03d24cfcc"))
  (when (modulep! :completion helm)
    (package! helm-lsp :pin "a005e935d537484c5afbaaf0ea6ddc7f429242dd"))
  (when (modulep! :completion vertico)
    (package! consult-lsp :pin "f41a3946987a3880068f95f3725bbb7b0d4b0b22")))
