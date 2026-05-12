;; -*- no-byte-compile: t; -*-
;;; app/calendar/packages.el

(when (package! calfw :pin "24fa167af96a6e677aea7c6b9385f669b550ee2f")
  (package! calfw-org)   ; part of calfw
  (package! calfw-cal)   ; part of calfw
  (package! calfw-ical)) ; part of calfw
(package! org-gcal :pin "fe700abff91fd84096d1a7d29ee25d21fc867e11")
