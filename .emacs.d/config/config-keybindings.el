(global-set-key (kbd "C-x g") 'magit-status)

(defun set-indent (n)
  (interactive "NTab width: ")
  (setq-local tab-width n)
  (setq-local tab-stop-list (number-sequence n 100 n)))

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
(global-set-key (kbd "C-x <up>") '(lambda () (interactive) (enlarge-window (- (- (frame-height) 10) (window-height)))))
(global-set-key (kbd "C-x <down>") '(lambda () (interactive) (enlarge-window (- (/ (frame-height) 3) (window-height)))))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c w") 'writegood-mode)
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-sexp)
(global-set-key (kbd "<f6>") 'set-indent)
(global-set-key (kbd "C-h C-f") 'find-function)

(provide 'config-keybindings)
