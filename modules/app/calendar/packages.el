;; -*- no-byte-compile: t; -*-
;;; app/calendar/packages.el

(when (package! calfw :pin "24fa167af96a6e677aea7c6b9385f669b550ee2f")
  (package! calfw-org)   ; part of calfw
  (package! calfw-cal)   ; part of calfw
  (package! calfw-ical)) ; part of calfw
(package! org-gcal :pin "5c230a1ef5902f2440d4521cb3a3588c6e5459b7")
