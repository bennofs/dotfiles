(defun my-run-latex ()
  (interactive)
  (setq TeX-save-query nil)
  (TeX-save-document (TeX-master-file))
  (TeX-command "LaTeX" 'TeX-master-file -1))

(eval-after-load "latex" '(progn
  (define-key LaTeX-mode-map (kbd "<f2>") 'my-run-latex)
  (define-key LaTeX-mode-map (kbd "<f7>") 'TeX-insert-macro)
  (define-key LaTeX-mode-map (kbd "<f8>") 'LaTeX-environment)
  (define-key LaTeX-mode-map (kbd "<f9>") 'LaTeX-section)
))

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq preview-default-preamble '(
  "\\RequirePackage[" ("," . preview-default-option-list) "]{preview}[2004/11/05]"
  "\\PreviewEnvironment{center}"
  "\\PreviewEnvironment{enumerate}"
  "\\PreviewEnvironment{itemize}"
  "\\PreviewEnvironment{lstlisting}"
  "\\PreviewEnvironment{minted}"
))

(setq TeX-view-program-selection '(
 ((output-dvi style-pstricks) "dvips and gv")
 (output-dvi "xdvi")
 (output-pdf "xdg-open")
 (output-html "xdg-open")
))

;; FIXME: Enabling -shell-escape globally is probably not a good idea. Maybe just enable it based on the used packages, or provide
;; a key for toggling it?
(setq preview-LaTeX-command-replacements (quote (("pdflatex" "pdflatex -shell-escape"))))

(provide 'config-auctex)
