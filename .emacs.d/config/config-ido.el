(setq ido-use-faces nil) 	
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".hs" ".tex" ".py" ".emacs" ".html" ".js" ".css" ".tpl" ".org"))
(setq ido-ignore-extensions t) 
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

(provide 'config-ido)
