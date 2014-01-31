(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-agenda-files (directory-files "/data/notes" t "^[^.][^.]*\.org\\'"))
(setq org-agenda-todo-list-sublevels nil)
(setq org-hide-leading-stars t)

(setq org-latex-listings t)

(eval-after-load 'org-export-latex '(progn 
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
))

(provide 'config-org)
