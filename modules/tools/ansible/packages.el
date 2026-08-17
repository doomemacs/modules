;; -*- no-byte-compile: t; -*-
;;; tools/ansible/packages.el

(package! ansible :recipe (:nonrecursive t) :pin "0d7bc93ad963677880d99c846a30ea6e6ed9eec5")
(package! ansible-doc :pin "86083a7bb2ed0468ca64e52076b06441a2f8e9e0")
(package! jinja2-mode :pin "03e5430a7efe1d163a16beaf3c82c5fd2c2caee1")
(package! yaml-mode :pin "5d7347519c94eac1c9383a3b9bebe218d3e43318")

(when (modulep! :completion company)
  (package! company-ansible :pin "338922601cf9e8ada863fe6f2dd9d5145d9983b0"))
