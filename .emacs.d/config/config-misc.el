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

(set-frame-parameter (selected-frame) 'alpha '(93 93))
(add-to-list 'default-frame-alist '(alpha 95 95))

(setq whitespace-style '(trailing face indentation empty))
(global-whitespace-mode 1)
(setq indent-tabs-mode nil)

(setq browse-url-browser-function 'browse-url-xdg-open)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq linum-format " %3d ")

(diredp-toggle-find-file-reuse-dir 1)
(projectile-global-mode 1)

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
(setq dired-listing-switches "-aBhl  --group-directories-first")

(defvar whitespace-on-save nil "Automatically clean whitespaces when saving?")
(make-variable-buffer-local 'whitespace-on-save)
(add-to-list 'safe-local-variable-values '(whitespace-on-save . t))
(add-to-list 'safe-local-variable-values '(whitespace-on-save . nil))
(add-hook 'before-save-hook '(lambda ()
    (if whitespace-on-save (delete-trailing-whitespace))
  ))

(provide 'config-misc)
