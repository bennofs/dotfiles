(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(savehist-mode t)
(show-paren-mode t)
(global-undo-tree-mode t)
(global-linum-mode 1)
(column-number-mode 1)
(cua-selection-mode 1)
(setq-default cursor-type 'bar)
(setq sml/theme 'respectful)
(sml/setup)

(setq inhibit-startup-screen t)
(setq initial-buffer-choice "/data/notes/main.org")
(setq inhibit-splash-screen t)

(setq whitespace-style '(trailing face indentation empty))
(global-whitespace-mode 1)
(setq indent-tabs-mode nil)
(setq prog-mode-hook 'clean-aindent-mode)

(setq browse-url-browser-function 'browse-url-xdg-open)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq linum-format " %3d ")

(diredp-toggle-find-file-reuse-dir 1)
(projectile-global-mode 1)

(setq dired-listing-switches "-aBhl  --group-directories-first")
(add-to-list 'completion-ignored-extensions ".hi")

(defvar whitespace-on-save nil "Automatically clean whitespaces when saving?")
(make-variable-buffer-local 'whitespace-on-save)
(add-to-list 'safe-local-variable-values '(whitespace-on-save . t))
(add-to-list 'safe-local-variable-values '(whitespace-on-save . nil))
(add-hook 'before-save-hook '(lambda ()
    (if whitespace-on-save (delete-trailing-whitespace))
  ))

(provide 'config-misc)
