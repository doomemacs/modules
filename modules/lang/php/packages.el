;; -*- no-byte-compile: t; -*-
;;; lang/php/packages.el

(package! psysh :pin "223bf55975d148f65f66bb8980c14c1230f067ff")
(package! php-mode :pin "75a2ca83b6a1c98781dd5e55ff4b8ffec285c39b")
(package! php-refactor-mode :pin "7a794b0618df2882b1bd586fdd698dba0bc5130d")
(package! phpunit :pin "650a50898de1fa4eeb47360b12aeb1126b2448c2")
(package! composer :pin "8cb5704eddab5205bd9e80977dfb81afb4a302bc")

(when (modulep! +hack)
  (package! hack-mode
    :recipe (:host github :repo "hhvm/hack-mode")
    :pin "0b117e7f259439e7b5d961ec936d8718a727c13a"))
