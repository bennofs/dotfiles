(defun my-run-latex ()
  (interactive)
  (if (buffer-modified-p)
      (progn  
        (setq TeX-save-query nil) 
        (TeX-save-document (TeX-master-file))
        (TeX-command "LaTeX" 'TeX-master-file -1))
    (TeX-view)))

(add-hook 'LaTeX-mode-hook '(lambda () (local-set-key (kbd "<f2>") 'my-run-latex)))

(setq TeX-command-force "")
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)


(provide 'config-auctex)
