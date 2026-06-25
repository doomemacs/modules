;;; term/ghostel/doctor.el -*- lexical-binding: t; -*-

(unless (fboundp 'module-load)
  (warn! "Your emacs wasn't built with dynamic modules support. The ghostel module won't load"))

(unless (executable-find "zig")
  (warn! "Couldn't find zig. Pre-built binaries cover most platforms; only needed if you want to compile the ghostel module from source via M-x ghostel-module-compile"))

(when (and (modulep! +evil) (not (modulep! :editor evil)))
  (warn! "+evil flag is enabled, but the :editor evil module isn't. evil-ghostel won't be loaded."))
