;; -*- no-byte-compile: t; -*-
;;; completion/corfu/packages.el

(package! corfu :pin "6477aac54fa1ea4865b23d7562e48b83a082a1e4")
(package! cape :pin "bd827d913f487d2bb3815731ac20b60419b9cb03")
(when (modulep! +icons)
  (package! nerd-icons-corfu :pin "f821e953b1a3dc9b381bc53486aabf366bf11cb1"))
(when (and (not (modulep! :completion vertico))
           (modulep! +orderless))
  ;; Enabling +orderless without vertico should be fairly niche enough that to
  ;; save contributor headaches we should only pin vertico's orderless and leave
  ;; this one unpinned.
  (package! orderless))
(when (and (modulep! :os tty)
           (not (featurep 'tty-child-frames)))
  (package! corfu-terminal :pin "501548c3d51f926c687e8cd838c5865ec45d03cc"))
(when (modulep! :editor snippets)
  (package! yasnippet-capf :pin "f53c42a996b86fc95b96bdc2deeb58581f48c666"))
