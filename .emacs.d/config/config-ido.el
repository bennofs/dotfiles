(setq ido-enable-flex-matching t)
(setq ido-everywhere t) 	
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".hs" ".tex" ".py" ".emacs" ".html" ".js" ".css" ".tpl" ".org"))
(setq ido-ignore-extensions t) 
(add-hook 'after-init-hook 'ido-mode)

(provide 'config-ido)
