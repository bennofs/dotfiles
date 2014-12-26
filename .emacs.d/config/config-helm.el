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

(helm-mode 1)
(global-set-key (kbd "C-c g")   'helm-google-suggest)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key
 (kbd "C-x b")
 #'(lambda ()
     (interactive)
     (helm-other-buffer
      '(helm-source-buffers-list
	helm-source-file-name-history
	helm-source-buffer-not-found
	)
      "*helm-buffers*")))

(require 'helm-projectile)
(helm-projectile-on)

(provide 'config-helm)
