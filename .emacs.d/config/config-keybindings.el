(global-set-key (kbd "C-x g") 'magit-status)
(electric-indent-mode 0)

(defun set-indent (n)
  (interactive "NTab width: ")
  (setq-local tab-width n)
  (setq-local tab-stop-list (number-sequence n 100 n))
  (setq-local c-basic-offset n))

(require 'misc)
(global-set-key (kbd "C-x t") (in-console (function eshell)))

(defun backward-delete-char-hungry (arg &optional killp)
  "*Delete characters backward in \"hungry\" mode.
    See the documentation of `backward-delete-char-untabify' and
    `backward-delete-char-untabify-method' for details."
  (interactive "*p\nP")
  (let ((backward-delete-char-untabify-method 'hungry))
    (backward-delete-char-untabify arg killp)))

(defun next-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (next-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not ( equal bread-crumb (buffer-name) )) )
      (next-buffer))))

(defun previous-code-buffer ()
  (interactive)
  (let ((bread-crumb (buffer-name)))
    (previous-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not (equal bread-crumb (buffer-name))))
      (previous-buffer))))
(global-set-key [remap next-buffer] 'next-code-buffer)
(global-set-key [remap previous-buffer] 'previous-code-buffer)

(global-set-key (kbd "M-DEL") 'backward-delete-char-hungry)
(global-set-key (kbd "M-<down>") 'previous-code-buffer)
(global-set-key (kbd "M-<up>") 'next-code-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-x <up>") 'enlarge-window)
(global-set-key (kbd "C-x <down>") 'shrink-window)
(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))
(global-set-key (kbd "C-S-<up>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window-horizontally)
(global-set-key (kbd "C-c w") 'writegood-mode)
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-sexp)
(global-set-key (kbd "<f6>") 'set-indent)
(global-set-key (kbd "C-h C-f") 'find-function)

(provide 'config-keybindings)
