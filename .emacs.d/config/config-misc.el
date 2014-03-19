(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(savehist-mode t)
(show-paren-mode t)
(global-undo-tree-mode t)
(global-linum-mode 1)
(column-number-mode 1)
(cua-selection-mode 1)

(setq inhibit-startup-screen t)
(setq initial-buffer-choice "/data/notes/main.org")
(setq inhibit-splash-screen t)

(server-mode 1)
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(setq browse-url-browser-function 'browse-url-xdg-open)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq linum-format " %3d ")

(diredp-toggle-find-file-reuse-dir 1)

(provide 'config-misc)
