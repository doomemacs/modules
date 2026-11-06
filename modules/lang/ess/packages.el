;; -*- no-byte-compile: t; -*-
;;; lang/ess/packages.el

(package! ess :pin "bb8f50f08798928c71fce20c7ea92fa16dbece0a")
(package! ess-view-data :pin "9d12c80097b532a5af4561a8c65f1862cb414c7a")
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
