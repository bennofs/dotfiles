(defun format-imports-hook ()
  (add-hook 'before-save-hook '(lambda () (save-excursion (haskell-mode-format-imports) (haskell-navigate-imports) (haskell-mode-format-imports))) t t)
)

(setq haskell-mode-hook '(capitalized-words-mode turn-on-haskell-indent turn-on-eldoc-mode turn-on-haskell-font-lock turn-on-haskell-decl-scan format-imports-hook))
(setq haskell-tags-on-save t)
(setq haskell-font-lock-symbols t)
(setq haskell-process-type 'cabal-repl)

(setq haskell-indent-dont-hang (quote ("(" "[" "{")))
(setq haskell-indent-offset 2)

(require 'haskell-session)

(eval-after-load "haskell-mode"
  '(progn
    (define-key haskell-mode-map (kbd "C-x C-d") nil)
    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
    (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c i")   'haskell-navigate-imports)
    (define-key haskell-mode-map (kbd "C-c b")   'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c c")   'haskell-cabal-visit-file)
    (define-key haskell-mode-map (kbd "C-c h")   'hayoo)
    (define-key haskell-mode-map (kbd "C-c g")   (in-console '(lambda () (switch-to-buffer (haskell-session-interactive-buffer (haskell-session))))))
    (define-key haskell-mode-map (kbd "C-c M-.") nil)
    (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(provide 'config-haskell)
