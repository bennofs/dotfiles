(global-flycheck-mode 1)
(setq flycheck-check-syntax-automatically '(save new-line mode-enabled idle-change))
(setq flycheck-idle-change-delay 0.5)

(flycheck-define-checker haskell-hdevtools
  "A Haskell syntax and type checker using hdevtools.

See URL `https://github.com/bitc/hdevtools'."
  :command ("hdevtools" "check" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ":"
            (or " " "\n    ") "Warning:" (optional "\n")
            (one-or-more " ")
            (message (one-or-more not-newline)
                     (zero-or-more "\n"
                                   (one-or-more " ")
                                   (one-or-more not-newline)))
            line-end)
   (error line-start (file-name) ":" line ":" column ":"
          (or (message (one-or-more not-newline))
              (and "\n" (one-or-more " ")
                   (message (one-or-more not-newline)
                            (zero-or-more "\n"
                                          (one-or-more " ")
                                          (one-or-more not-newline)))))
          line-end))
  :modes (haskell-mode literate-haskell-mode)
  :next-checkers ((warnings-only . haskell-hlint)))
(add-to-list 'flycheck-checkers 'haskell-hdevtools)

(provide 'config-flycheck)
