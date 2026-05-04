;; -*- no-byte-compile: t; -*-
;;; app/calendar/packages.el

(when (package! calfw :pin "24fa167af96a6e677aea7c6b9385f669b550ee2f")
  (package! calfw-org)   ; part of calfw
  (package! calfw-cal)   ; part of calfw
  (package! calfw-ical)) ; part of calfw
(package! org-gcal :pin "b826356a01a7484bae6245a695059a6f8d36726a")
