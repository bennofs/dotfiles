(require 'cask "~/progs/cask/cask.el")
(cask-initialize)

(require 'pallet)
(require 'nix-mode)

(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/lib")
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
