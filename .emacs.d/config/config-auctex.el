(defun my-run-latex ()
  (interactive)
  (if (buffer-modified-p)
      (progn  
        (setq TeX-save-query nil) 
        (TeX-save-document (TeX-master-file))
        (TeX-command "LaTeX" 'TeX-master-file -1))
    (TeX-view)))

(add-hook 'LaTeX-mode-hook '(lambda () 
  (local-set-key (kbd "<f2>") 'my-run-latex)
  (visual-line-mode)
))

(setq TeX-command-force "")
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

;; FIXME: Enabling -shell-escape globally is probably not a good idea. Maybe just enable it based on the used packages, or provide
;; a key for toggling it?
(setq preview-LaTeX-command-replacements (quote (("pdflatex" "pdflatex -shell-escape"))))
(setq TeX-command-list '(
  ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode) -shell-escape%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") 
  ("LaTeX" "%`%l%(mode) -shell-escape%' %t" TeX-run-command nil (latex-mode doctex-mode) :help "Run LaTeX") 
  ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") 
  ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output")
  ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX")
  ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once")
  ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion")
  ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
  ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
  ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
  ("Print" "%p" TeX-run-command t t :help "Print the file")
  ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
  ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
  ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
  ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness")
  ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
  ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
  ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
  ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))

(provide 'config-auctex)
