;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; misc
; no prompt on quit
(setq confirm-kill-emacs nil)
(setq make-backup-files t)

;; theming
(setq doom-theme 'tao-one-light)
(setq doom-font (font-spec :family "Source Code Pro" :size 10.0))

(use-package! eziam-theme
  :defer t
  :init
  (setq-default eziam-scale-headings nil)
  (setq-default eziam-scale-other nil))

(use-package! rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode)
  :hook (promela-mode . rainbow-identifiers-mode)
  :commands (global-rainbow-identifiers-mode rainbow-identifiers-mode)
  :init
  (setq-default rainbow-identifiers-choose-face-function #'rainbow-identifiers-cie-l*a*b*-choose-face)
  (setq-default rainbow-identifiers-cie-l*a*b*-saturation 60)
  (setq-default rainbow-identifiers-cie-l*a*b*-lightness 30)
  (setq-default rainbow-identifiers-faces-to-override '(font-lock-variable-name-face font-lock-function-name-face)))

;; customize keybinds
(map! :leader
      "hj" #'find-function
      "wz" #'+hydra/text-zoom/body
      "w." #'+hydra/window-nav/body)

(defun +own/sp-get-sexp-around-point (count)
  (let*
      ((current-sexp (sp-get-sexp))
       (new-count (if (= (sp-get current-sexp :beg) (point)) (- count 1) count)))
    (if (= new-count 0) current-sexp (sp-get-enclosing-sexp new-count))))

(after! evil
  ; o/O should not continue comments
  (setq +evil-want-o/O-to-continue-comments nil)

  ; alias ö and ä to [ and ] in vim movement keybindings
  (define-key evil-normal-state-map (kbd "ö") (lookup-key evil-normal-state-map (kbd "[")))
  (define-key evil-normal-state-map (kbd "ä") (lookup-key evil-normal-state-map (kbd "]")))
  (define-key evil-motion-state-map (kbd "ö") (lookup-key evil-motion-state-map (kbd "[")))
  (define-key evil-motion-state-map (kbd "ä") (lookup-key evil-motion-state-map (kbd "]"))))

; ü for jump
(map! :n "ü" #'+lookup/definition)

; swap C-l and Tab in ivy (make Tab complete selected match, not longest prefix)
(after! ivy
  (define-key ivy-minibuffer-map (kbd "C-l") #'ivy-partial-or-done)
  (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-alt-done))

; hydra for multiple-cursors
(defvar own--mc-hydra-frozen nil)
(defun +own/exit-mc-hydra (&optional clear)
  "Cleanup after evil multiple-cursors hydra"
  (when clear (evil-mc-undo-all-cursors))
  (setq evil-mc-frozen own--mc-hydra-frozen))
(defun +own/enter-mc-hydra ()
  "Activate the hydra for multiple cursors"
  (interactive)
  (setq own--mc-hydra-frozen (bound-and-true-p evil-mc-frozen))
  (evil-mc-pause-cursors)
  (+hydra/mc-set/body))

(defhydra +hydra/mc-set (:color pink
                         :post (progn
                                 (setq evil-mc-frozen own--mc-hydra-frozen)))
  "hydra for quickly adding multiple cursors"
  ("<escape>" evil-mc-undo-all-cursors :color blue)
  ("<SPC>" nil :color blue)
  ("<RET>" nil :color blue)
  ("d" evil-mc-make-and-goto-next-match)
  ("D" evil-mc-make-and-goto-prev-match)
  ("j" evil-mc-make-cursor-move-next-line)
  ("k" evil-mc-make-cursor-move-prev-line)
  ("J" evl-next-line)
  ("K" evil-prev-line)
  ("n" evil-mc-make-and-goto-next-cursor)
  ("N" evil-mc-make-and-goto-last-cursor)
  ("p" evil-mc-make-and-goto-prev-cursor)
  ("P" evil-mc-make-and-goto-first-cursor)
  ("c" evil-mc-undo-all-cursors)
  ("u" evil-mc-undo-last-added-cursor)
  ("z" +multiple-cursors/evil-mc-make-cursor-here))
(map! :n "gz." #'+own/enter-mc-hydra)

;; configure org
(setq org-directory "/data/share/org")
(after! org
  (setq-default
   org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAIT(w)" "REPLY(r)" "|" "DONE(d)")
                       (type "IDEA(i)")
                       (sequence "|" "CANCELED(c)" "DELEGATED(d)" "FUTURE(f)"))
   org-default-notes-file "/data/share/projects.org"
   org-agenda-files '("/data/share/projects.org")
   org-agenda-sorting-strategy
   '((agenda habit-down time-up todo-state-down priority-down category-keep)
     (todo priority-down todo-state-down category-keep)
     (tags priority-down category-keep)
     (search category-keep))
   org-projectile-file "/data/share/projects.org"
   org-todo-keyword-faces
   '(("TODO" . (:foreground "#cc9393" :background nil :weight bold))
     ("DONE" . (:foreground "#afd8af" :background nil :weight bold))
     ("NEXT" . (:foreground "#dca3a3" :background nil :weight bold)))))

(after! parse-time
  (setq-default
   parse-time-weekdays (append parse-time-weekdays
                               '(("mo" . 1)
                                 ("di" . 2) ("tu" . 2)
                                 ("mi" . 3) ("we" . 3)
                                 ("th" . 4) ("do" . 4)
                                 ("fr" . 5)
                                 ("sa" . 6)
                                 ("so" . 0) ("su" . 0)))))

(use-package! org-projectile
  :after org-agenda
  :config
  (setq-default
   org-projectile-projects-file "/data/share/projects.org"
   org-capture-templates
   `(,(org-projectile-project-todo-entry)
     ("t" "todo task" entry (file+headline "" "tasks") "** TODO %?" :prepend t)
     ("r" "reply task" entry (file+headline "" "tasks") "** REPLY %?" :prepend t)
     ("A" "Ascii mail" entry (file+headline "" "ascii") "** REPLY %?" :prepend t)
     ("a" "Ascii VoSI" entry (file+headline "" "VoSI TOPs") "*** %?"))))

(defun +org-present-init-hook ()
  (doom-big-font-mode 1)
  (setq-local display-line-numbers nil)
  (org-toggle-pretty-entities)
  (org-display-inline-images)
  (hide-lines-matching "#\\+BEGIN_")
  (hide-lines-matching "#\\+END_")
  (org-present-beginning))

(defun +org-present-quit-hook ()
  (org-toggle-pretty-entities)
  (doom-big-font-mode 0)
  (org-remove-inline-images)
  (hide-lines-show-all))

(use-package! org-present
  :after org
  :bind (:map org-mode-map
          ("<f7>" . org-present-mode))
  :config
  (map! :map org-present-mode-keymap
        "<f7>" 'org-present-quit
        "<f8>" 'org-present-prev
        "<f9>" 'org-present-next)
  (add-hook 'org-present-mode-hook #'+org-present-init-hook)
  (add-hook 'org-present-mode-quit-hook #'+org-present-quit-hook)
  )

(setq bibtex-completion-notes-path "/data/share/notes/research.org")
(setq bibtex-completion-library-path "/data/share/pdfs")
(setq bibtex-completion-bibliography "/data/share/references.bib")
(setq reftex-default-bibliography "/code/hauptseminar/ref.bib")

;; let's add some fruits to pomodoro notifications
(defadvice! my--pomodoro-notify-a (orig-fn title message)
  :around #'org-pomodoro-notify
  (funcall orig-fn (concat "🍅 " title) message))

; we want doom scratch buffer to use org-mode
(setq-default doom-scratch-buffer-major-mode 'org-mode)

;; lang configurations
(setq-default rustic-lsp-server 'rust-analyzer)
(setq-default lsp-rust-analyzer-cargo-watch-args ["--profile", "test"])
(setq-default lsp-rust-analyzer-cargo-all-targets t)

; disable lsp ui inline display of error messages (its too buggy)
(setq-default lsp-ui-sideline-enable nil)

; don't display documentation in lsp signatures by default
(setq-default lsp-signature-doc-lines 0)

; make the threshold a bit bigger (default is 1000)
; even gnu coreutils repo has already >1k files
(setq-default lsp-file-watch-threshold 15000)

(use-package! promela-mode
  :defer t
  :mode "\\.promela$"
  :mode "\\.spin$"
  :mode "\\.pml$")

; vereofy reo scripting language basic support
(define-derived-mode vereofy-major-mode prog-mode
  "vereofy"
  (electric-indent-mode 9))
(add-to-list 'auto-mode-alist '("\\.rsl\\'" . vereofy-major-mode))
