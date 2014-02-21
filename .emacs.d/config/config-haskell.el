(add-to-list 'load-path "~/.emacs.d/plugins/hare")
(require 'hare)
(autoload 'hare-init "hare" nil t)

(defun format-imports-hook ()
  (add-hook 'before-save-hook '(lambda () (if haskell-format-on-save (save-excursion (haskell-sort-imports) (haskell-navigate-imports) (haskell-sort-imports)))) t t)
)

(defvar haskell-format-on-save nil "Run haskell-mode-format-imports on save?")
(make-variable-buffer-local 'haskell-format-on-save)
(add-to-list 'safe-local-variable-values '(haskell-format-on-save . t))
(add-to-list 'safe-local-variable-values '(haskell-format-on-save . nil))

(setq haskell-mode-hook '(capitalized-words-mode turn-on-haskell-indent turn-on-eldoc-mode turn-on-haskell-font-lock turn-on-haskell-decl-scan format-imports-hook (lambda () (hare-init))))
(setq haskell-tags-on-save t)
(setq haskell-font-lock-symbols t)
(setq haskell-process-type 'ghci)
(setq haskell-process-path-ghci "/home/bin/ghci-ng")
(setq haskell-process-args-cabal-repl '("--ghc-option=-ferror-spans" "--with-ghc=/home/bin/ghci-ng"))

(setq haskell-indent-dont-hang (quote ("(" "[" "{")))
(setq haskell-indent-offset 2)
(setq haskell-process-log t)

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
    (define-key haskell-mode-map (kbd "C-c g")   '(lambda () 
      (interactive)
      (let ((session (haskell-session)))
           (funcall (in-console '(lambda () (switch-to-buffer (haskell-session-interactive-buffer session)))))
      )
    ))
    (define-key haskell-mode-map (kbd "C-c M-.") nil)
    (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(provide 'config-haskell)
