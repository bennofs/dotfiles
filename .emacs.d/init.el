(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/lib")

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(byte-recompile-directory (expand-file-name "~/.emacs.d/config") 0)

(require 'pallet)
(require 'nix-mode)

(require 'config-theme)
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
