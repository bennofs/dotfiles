(require 'proof-site "ProofGeneral/generic/proof-site")
(setq proof-splash-enable nil)
(setq coq-one-command-per-line nil)
(eval-after-load 'proof-faces #'(progn
  (set-face-attribute 'proof-eager-annotation-face nil :background "#733105")
  (set-face-attribute 'proof-locked-face nil :background "#073642")
  (set-face-attribute 'proof-queue-face nil :background "turquoise1")
  ))

(eval-after-load 'proof-script #'(progn
  (define-key proof-mode-map (kbd "M-<down>") 'proof-assert-next-command-interactive)
  (define-key proof-mode-map (kbd "M-<up>")   'proof-undo-last-successful-command)
  (define-key proof-mode-map (kbd "M-RET")    'proof-assert-until-point-interactive)
  (define-key proof-mode-map (kbd ".") #'(progn (interactive) (indent-according-to-mode) (proof-electric-terminator)))
  ))

(provide 'config-pg)
