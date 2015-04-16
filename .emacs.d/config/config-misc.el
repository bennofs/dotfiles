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

(setq whitespace-style '(face indentation empty))
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

(setq backup-directory-alist '(("" . "/data/backup/emacs/")))
(setq auto-save-file-name-transforms '((".*" "/data/backup/emacs/" t)))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(auto-save-mode 1)

(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
      (progn
	;; disable backups
	(set (make-local-variable 'backup-inhibited) t)	
	;; disable auto-save
	(if auto-save-default
	    (auto-save-mode -1)))
    ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
    ;resort to default auto save setting
    (if auto-save-default
	(auto-save-mode 1))))
(setq auto-mode-alist
 (append '(("\\.gpg$" . sensitive-mode)
	   ("^/etc/nixos/conf/accounts" . sensitive-mode)
	   ("^/sudo:" . sensitive-mode)
	   ("sudo:" . sensitive-mode))
	 auto-mode-alist))

(provide 'config-misc)
