(require 'helm-config)

(eval-after-load 'helm
  #'(progn
      (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
      (define-key helm-map (kbd "C-z")   'helm-select-action))) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t) ; open helm buffer inside current window, not occupy whole other window
(setq helm-move-to-line-cycle-in-source     t) ; move to end or beginning of source when reaching top or bottom of source.
(setq helm-ff-skip-boring-files             t)
(setq helm-ff-file-name-history-use-recentf t)

(helm-mode 1)
(global-set-key (kbd "C-c g")   'helm-google-suggest)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key
 (kbd "C-x b")
 #'(lambda ()
     (interactive)
     (unless helm-source-buffers-list
       (setq helm-source-buffers-list
	     (helm-make-source "Buffers" 'helm-source-buffers)))
     (let ((helm-ff-transformer-show-only-basename nil))
       (helm :sources '(helm-source-buffers-list
			helm-source-ido-virtual-buffers
			helm-source-recentf
			helm-source-buffer-not-found)
	     :buffer "*helm-buffers*"
	     :keymap helm-buffer-map
	     :truncate-lines t))))

(setq helm-boring-file-regexp-list
      (mapcar (lambda (f)
		(concat
		 (rx-to-string
		  (replace-regexp-in-string
		   "/$" "" f) t) "$"))
	      completion-ignored-extensions))
(global-set-key (kbd "C-x i") 'helm-imenu)

(require 'helm-projectile)
(require 'helm-buffers)
(helm-projectile-on)

(provide 'config-helm)
