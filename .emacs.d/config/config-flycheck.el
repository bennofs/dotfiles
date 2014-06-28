(global-flycheck-mode 1)
(setq flycheck-check-syntax-automatically '(save mode-enabled idle-change))
(setq flycheck-idle-change-delay 0.5)
(setq-default flycheck-disabled-checkers '(haskell-ghc))

(defvar-local flycheck-external-errors nil
  "Flycheck errors provided by external libraries.")


(eval-after-load "flycheck" #'(progn
  (defun flycheck-clear-errors ()
    "Remove all error information from the current buffer."
    (setq flycheck-current-errors flycheck-external-errors)
    (flycheck-report-status ""))
  (add-hook 'flycheck-after-syntax-check-hook (lambda ()
   (--each flycheck-external-errors (run-hook-with-args-until-success 'flycheck-process-error-functions it))
  ))
))


(provide 'config-flycheck)
