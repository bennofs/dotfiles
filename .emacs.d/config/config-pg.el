(require 'proof-site "ProofGeneral/generic/proof-site")
(setq proof-splash-enable nil)
(setq coq-one-command-per-line nil)
(eval-after-load 'proof-faces #'(progn
  (set-face-attribute 'proof-eager-annotation-face nil :background "#733105")
  (set-face-attribute 'proof-locked-face nil :background "#073642")
  (set-face-attribute 'proof-queue-face nil :background "turquoise1")
  ))

(eval-after-load 'proof-script #'(progn
  (defun electric-space ()
    (when (char-after)
      (unless (char-equal (char-syntax (char-after)) ?\s)
	(save-excursion (insert " ")))))

  (define-key proof-mode-map (kbd "M-<down>") 'proof-assert-next-command-interactive)
  (define-key proof-mode-map (kbd "M-<up>")   'proof-undo-last-successful-command)
  (define-key proof-mode-map (kbd "M-RET")    'proof-assert-until-point-interactive)
  (define-key proof-mode-map (kbd "C-.")      (lambda () (interactive) (insert ".")))
  (advice-add 'proof-electric-terminator :before
	      #'(lambda (&rest args) (indent-according-to-mode) (electric-space)))
  ))

(eval-after-load 'coq #'(progn
  (define-key coq-mode-map (kbd "M-#")
    #'(lambda ()
	(interactive)
	(coq-end-Section)
	(indent-according-to-mode)))))

(add-hook 'coq-mode-hook 'electric-indent-local-mode)

(provide 'config-pg)
