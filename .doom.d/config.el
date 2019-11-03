;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; theming
(setq doom-theme 'doom-one-light)

(use-package! eziam-theme
  :defer t
  :init
  (setq-default eziam-scale-headings nil)
  (setq-default eziam-scale-other nil))

(use-package! rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode)
  :commands (global-rainbow-identifiers-mode rainbow-identifiers-mode)
  :init
  (setq-default rainbow-identifiers-choose-face-function #'rainbow-identifiers-cie-l*a*b*-choose-face)
  (setq-default rainbow-identifiers-cie-l*a*b*-saturation 60)
  (setq-default rainbow-identifiers-cie-l*a*b*-lightness 30)
  (setq-default rainbow-identifiers-faces-to-override '(font-lock-variable-name-face font-lock-function-name-face)))

;; customize keybinds
(map! :leader
      "hj" #'find-function
      "tz" #'+hydra/text-zoom/body
      "w." #'+hydra/window-nav/body)

; we want <SPC> j for search (/ is hard to type)
(define-key doom-leader-map (kbd "j") doom-leader-search-map)

; alias ö and ä to [ and ] in vim movement keybindings
(after! evil
  (define-key evil-normal-state-map (kbd "ö") (lookup-key evil-normal-state-map (kbd "[")))
  (define-key evil-normal-state-map (kbd "ä") (lookup-key evil-normal-state-map (kbd "]")))
  (define-key evil-motion-state-map (kbd "ö") (lookup-key evil-motion-state-map (kbd "[")))
  (define-key evil-motion-state-map (kbd "ä") (lookup-key evil-motion-state-map (kbd "]"))))

; ü for jump
(map! :n "ü" #'+lookup/definition)

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
  ("J" evil-mc-make-cursor-move-next-line)
  ("K" evil-mc-make-cursor-move-prev-line)
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
   org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAIT(w)" "REPLY(r)" "|" "DONE(d)")
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

;; lang configurations
; disable lsp ui inline display of error messages (its too buggy)
(setq lsp-ui-sideline-enable nil)

; enable python version switching
(defvar +python-interpreter-executable-history nil
    "History list for recently selected python interpreters.")

(defun +set-python-interpreter-executable (command)
    "Set the python interpreter for the current buffer to the given executable."
    (interactive
     (list
      (read-shell-command
       "Python interpreter: " nil '+python-interpreter-executable-history "python"
       )))
    (setq-local python-shell-interpreter command)
    (setq-local flycheck-python-pycompile-executable command)
    (setq-local lsp-python-ms-python-executable-cmd command)
    (when (= (length lsp--buffer-workspaces) 1)
      (lsp-workspace-restart (nth 0 lsp--buffer-workspaces)))
    (flycheck-buffer)
    (doom-modeline-env-update-python)
    (let
        ((process (python-shell-get-process)))
      (when (and process (y-or-n-p "Python interpreter already running. Kill currently running process?"))
        (kill-process process))))

(after! python
  (map! :map python-mode-map
        :localleader
        "p" #'+set-python-interpreter-executable))
