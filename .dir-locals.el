((nil
  (git-commit-major-mode . git-commit-elisp-text-mode)
  (fill-column . 80))
 (doom-docs-org-mode
  (doom-docs-repo "https://git.doomemacs.org/modules")
  (doom-docs-menus
   ("/README\\.org$"
    (left  ("← Back: core" . "doomemacs:core")))
   ("/[^/]+/README\\.org$"
    (left  ("← Back: module index" . "file:../README.org")))
   ("/\\([^/]+\\)/\\([^/]+\\)/README\\.org$"
    (left  ("← Back: module index" . "file:../../README.org")
           ("↑ Up: \\1" . "file:../README.org"))
    (right ("↖ History" . "github-commits:./")
           ("! Issues"  . "github-label:module:\\1/\\2"))))))
