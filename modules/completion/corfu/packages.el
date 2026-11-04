;; -*- no-byte-compile: t; -*-
;;; completion/corfu/packages.el

(package! corfu :pin "15fed49c97bf6b2436641714ae15bbd2f3e37b77")
(package! cape :pin "50bc6187daf9af9df1a802fcbbd91fe4b952fc69")
(when (modulep! +icons)
  (package! nerd-icons-corfu :pin "9b089b31a810328d9b740b35a19eb796eb7a2d8a"))
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
