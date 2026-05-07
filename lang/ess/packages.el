;; -*- no-byte-compile: t; -*-
;;; lang/ess/packages.el

(package! ess :pin "bb84ad5717ead180488cf4f266c38eace890e314")
(package! ess-view-data :pin "7dcbd23d4cef2030753d16e1ca1811d3466484e7")
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
