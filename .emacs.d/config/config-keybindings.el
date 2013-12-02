(global-set-key (kbd "C-x g") 'magit-status)

(require 'misc)
(global-set-key (kbd "C-x t") (in-console (function eshell)))

(defun backward-delete-char-hungry (arg &optional killp)
  "*Delete characters backward in \"hungry\" mode.
    See the documentation of `backward-delete-char-untabify' and
    `backward-delete-char-untabify-method' for details."
  (interactive "*p\nP")
  (let ((backward-delete-char-untabify-method 'hungry))
    (backward-delete-char-untabify arg killp)))

(global-set-key (kbd "M-DEL") 'backward-delete-char-hungry)
(global-set-key (kbd "M-<down>") 'previous-buffer)
(global-set-key (kbd "M-<up>") 'next-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'config-keybindings)
