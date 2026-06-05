;; -*- no-byte-compile: t; -*-
;;; lang/janet/packages.el

(package! janet-mode
  :recipe (:files ("*.el"))
  :pin "9e3254a0249d720d5fa5603f1f8c3ed0612695af")

(when (and (modulep! +tree-sitter) (treesit-available-p))
  (package! janet-ts-mode
    :recipe (:host github :repo "sogaiu/janet-ts-mode")
    :pin "f818754b06336b699ea4ac8a202f7999a44eaf49"))

(when (modulep! :checkers syntax +flymake)
  (package! flymake-janet
    :recipe (:host github :repo "torusJKL/flymake-janet")
    :pin "24a73fa8f9205bc877ba07119930fc14da41ce0d"))
