;;; term/ghostel/config.el -*- lexical-binding: t; -*-

(use-package! ghostel
  :when (bound-and-true-p module-file-suffix) ; requires dynamic-modules support
  :commands ghostel-mode
  :hook ((ghostel-mode . mode-line-invisible-mode) ; modeline serves no purpose in a terminal
         (ghostel-mode . doom-disable-line-numbers-h))
  :config
  (set-popup-rule! "^\\*ghostel" :size 0.25 :vslot -4 :select t :quit nil :ttl 0)

  (setq-hook! 'ghostel-mode-hook
    ;; Don't prompt about dying processes when killing ghostel
    confirm-kill-processes nil
    ;; Prevent premature horizontal scrolling
    hscroll-margin 0)

  (when (modulep! +compilation-mode)
    (ghostel-compile-global-mode +1))

  (when (modulep! +comint-mode)
    (ghostel-comint-global-mode +1))

  (when (and (modulep! +eshell)
             (modulep! :term eshell))
    (add-hook 'eshell-load-hook #'ghostel-eshell-visual-command-mode)))

(use-package! evil-ghostel
  :when (and (modulep! +evil) (modulep! :editor evil))
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))
