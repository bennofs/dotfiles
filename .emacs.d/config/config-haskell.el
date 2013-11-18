(setq haskell-mode-hook '(capitalized-words-mode turn-on-haskell-indentation turn-on-eldoc-mode turn-on-haskell-font-lock))
(setq haskell-tags-on-save t)
(setq haskell-font-lock-symbols t)
(setq haskell-process-type 'cabal-repl)

(provide 'config-haskell)
