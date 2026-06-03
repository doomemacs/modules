;; -*- no-byte-compile: t; -*-
;;; tools/lsp/packages.el

(if (modulep! +eglot)
    (progn
      (package! eglot :pin "1a0f3720eb36173612d9a5c8925d4dedce850f62")
      (package! jsonrpc :pin "0135c781e636b97ff6c6173be236f43df67e6c06")
      (when (modulep! :completion vertico)
        (package! consult-eglot :pin "d8b444aac39edfc6473ffbd228df3e9119451b51"))
      (when (modulep! :checkers syntax -flymake)
        (package! flycheck-eglot :pin "cd1dd78cec0ae1f566c765d98bbff322cc7b67ef"))
      (when (modulep! +booster)
        (package! eglot-booster
          :recipe (:host github :repo "jdtsmith/eglot-booster")
          :pin "cab7803c4f0adc7fff9da6680f90110674bb7a22")))

  ;; lsp-mode must be rebuilt if this variable is changed, so expose it here so
  ;; users can change it from $DOOMDIR/packages.el.
  (eval-and-compile (defvar lsp-use-plists t))

  (package! lsp-mode
    :pin "fbd7d03ce1353b3071d767a21b23b49cb5f6c7c6"
    :env `(("LSP_USE_PLISTS" . ,(and lsp-use-plists "1"))))
  (package! lsp-ui :pin "8d888a3ab1ba9e46bd4711398c57d39d0b709a45")
  (when (modulep! :completion ivy)
    (package! lsp-ivy :pin "c0930544948dfdb7bf497fc9e58aa6b4b857e237"))
  (when (modulep! :completion helm)
    (package! helm-lsp :pin "056bb16b5f69137218613b7558b477f6b21f22be"))
  (when (modulep! :completion vertico)
    (package! consult-lsp :pin "d11102c9db33c4ca7817296a2edafc3e26a61117")))
