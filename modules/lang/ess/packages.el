;; -*- no-byte-compile: t; -*-
;;; lang/ess/packages.el

(package! ess :pin "c3960e09f37550d300437c46ca03fb28975378a1")
(package! ess-view-data :pin "831be384d0045ae9ff1f4b8ae2b5090377938475")
(package! poly-R :pin "fee0b6e99943fa49ca5ba8ae1a97cbed5ed51946")
(package! quarto-mode :pin "a7b974f7d22ef939eaed8b9919434bcf20b1438f")

(package! polymode :pin "8cb72fa5dcc0d98746c680043dc121edc7621e3a")

(when (modulep! +stan)
  (package! stan-mode :pin "2bfd1484e1a99f9971b1a8aa1b587cdca411ab55")
  (package! eldoc-stan :pin "2bfd1484e1a99f9971b1a8aa1b587cdca411ab55")
  (when (modulep! :completion company)
    (package! company-stan :pin "2bfd1484e1a99f9971b1a8aa1b587cdca411ab55"))
  (when (modulep! :checkers syntax -flymake)
    (package! flycheck-stan :pin "2bfd1484e1a99f9971b1a8aa1b587cdca411ab55")))
