(defun org-template-writeup-get-meta (info)
  (let ((keywords (format "%s" (org-export-data (org-latex--wrap-latex-math-block
                                    (plist-get info :keywords) info)
                                   info)))
        (points (org-entry-get nil "points" t)))
    (s-join ", " (remove-if-not 'org-string-nw-p (list keywords (and points (concat points " pts")))))))

(defun org-template-writeup (info)
  (list :latex-classes
        '(("writeup"
           "\\documentclass[11pt,parskip=half]{scrartcl}"
           ("\\section*{%s}" . "\\section*{%s}")
           ("\\subsection*{%s}" . "\\subsection*{%s}")
           ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph*{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph*{%s}" . "\\subparagraph*{%s}")))
        :latex-listings 'minted
        :latex-class "writeup"
        :latex-subtitle-separate t
        :latex-subtitle-format "\\subtitle{%s}"
        :latex-image-default-width "\\widewidth"
        :latex-header
        (concat
         (format "\\newcommand\\meta{%s}" (org-template-writeup-get-meta info))
         "
\\usepackage{minted}
\\usepackage{fancyvrb}
\\usepackage{changepage}
\\newlength{\\widewidth}
\\setlength{\\widewidth}{0.5\\textwidth}
\\addtolength{\\widewidth}{0.5\\paperwidth}
\\newlength{\\wideoverflow}
\\setlength{\\wideoverflow}{0.5\\widewidth}
\\addtolength{\\wideoverflow}{-0.5\\textwidth}
\\setminted{breaklines}
\\let\\latexcenter\\center
\\let\\latexendcenter\\endcenter
\\newsavebox\\centerbox
\\renewenvironment{center}{%
  \\begin{lrbox}{\\centerbox}
}{%
  \\end{lrbox}%
  \\ifdim\\wd\\centerbox<\\textwidth%
  \\trivlist\\item\\usebox{\\centerbox}\\endtrivlist%
  \\else%
  \\adjustwidth{-\\wideoverflow}{-\\wideoverflow}\\centering\\usebox{\\centerbox}\\endadjustwidth%
  \\fi%
}
\\renewenvironment{verbatim}{%
  \\VerbatimEnvironment
  \\begin{center}
  \\begin{BVerbatim}[fontsize=\\small]%
}
{\\end{BVerbatim}\\end{center}}
\\newenvironment{breakresults}{\\minted[breaklines,breakanywhere,xleftmargin=-\\wideoverflow,xrightmargin=-\\wideoverflow]{text}}{\\endminted}
\\makeatletter
\\renewcommand{\\maketitle}{
{\\LARGE \\@title}\\hfill\\hfill\\meta\\par\\vspace{0.25em}
{\\em \\@subtitle}\\par\\vspace{0.25em}
}
\\let\\latexincludegraphics\\includegraphics
\\renewcommand{\\includegraphics}[2][]{\\makebox[\\textwidth][c]{\\latexincludegraphics[#1]{#2}}}
\\makeatother
")
        :with-toc nil)) 
