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
(server-mode 1)
(set-frame-parameter (selected-frame) 'alpha '(97 97))
(add-to-list 'default-frame-alist '(alpha 97 97))

(setq browse-url-browser-function 'browse-url-chromium)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq linum-format " %3d ")

(provide 'config-misc)
