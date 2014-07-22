(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'config-theme)

(byte-recompile-directory (expand-file-name "~/.emacs.d/config") 0)
(byte-recompile-directory (expand-file-name "~/.emacs.d/themes") 0)

(require 'pallet)
(require 'nix-mode)

(require 'config-faces)
(require 'config-misc)
(require 'config-ido)
(require 'config-powerline)
(require 'config-haskell)
(require 'config-filetypes)
(require 'config-keybindings)
(require 'config-flycheck)
(require 'config-org)
(require 'config-yasnippet)
(require 'config-auctex)
(require 'config-magit)
(require 'config-eshell)

(setq custom-file "~/.emacs.d/config/config-customize.el")
(load custom-file)
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
