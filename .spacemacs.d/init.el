;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d")
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   `(swift
     nginx
     windows-scripts
     graphviz
     (latex :variables latex-enable-auto-fill nil)
     systemd
     (go :variables go-tab-width 4 godoc-at-point-function 'godoc-gogetdoc)
     react
     perl5
     protobuf
     asciidoc
     sql
     d
     javascript
     auto-completion
     (c-c++ :variables c-c++-default-mode-for-headers 'c++-mode)
     csv
     (colors :variables colors-colorize-identifiers 'all)
     cscope
     csharp
     docker
     emacs-lisp
     (erc :variables
          erc-enable-sasl-auth t
          erc-server-list
          '(("irc.freenode.net"
             :port "6697"
             :ssl t
             :nick "bennofs")))
     major-modes
     git
     github
     (haskell :variables haskell-completion-backend 'company-ghci)
     helm
     html
     lua
     (markdown :variables markdown-live-preview-engine 'vmd)
     nixos
     ocaml
     org
     perl6
     php
     (python :variables python-backend 'anaconda)
     ruby
     rust
     scala
     (shell :variables shell-default-shell 'eshell)
     shell-scripts 
     spacemacs-purpose
     spell-checking
     syntax-checking
     typescript
     (version-control :variables version-control-global-margin t version-control-diff-tool 'diff-hl)
     vimscript
     yaml
     ycmd
     cmake
     pdf
     dash
     semantic-web
     bibtex
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(all-the-icons
     evil-smartparens
     ob-ipython
     yasnippet-snippets
     bison-mode
     nasm-mode
     dtrt-indent
     eziam-theme)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages
   '(magithub ; more broken than magit-gh-pulls
     )
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   exec-path-from-shell-arguments (list "-l") 
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; Example for 5 recent files and 7 projects: '((recents . 5) (projects . 7))
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; (default nil)
   dotspacemacs-startup-lists '((recents . 5) (projects . 5))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(eziam-light solarized-light solarized-dark)
   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator arrow :separator-scale 1.0)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Fira Mono"
                               :size 13
                               :weight Regular
                               :width normal
                               :powerline-scale 1.5)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-SPC"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key "ö"
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text t
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "pt" "ag" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (let ((base-dir (file-name-as-directory (file-name-directory (dotspacemacs/location)))))
    ;; Set custom file to a different file so it can be ignored by git
    (setq custom-file (concat base-dir "customize.el"))
    (when (file-exists-p custom-file) (load custom-file)))

  ;; Configure the solarized theme
  (setq-default solarized-distinct-fringe-background nil)
  (setq-default solarized-high-contrast-mode-line t)
  (setq-default spacemacs--fallback-theme 'spacemacs-light)
  (setq-default eziam-scale-headings nil)
  (setq-default eziam-scale-other nil)

  (custom-theme-set-faces
   'user
   '(sp-show-pair-match-face ((t (:foreground "dark blue" :weight bold :underline t))) t)
   '(helm-minibuffer-prompt ((t (:foreground "yellow")))))


  ;; Disable clipboard manager (for wayland support)
  (setq-default x-select-enable-clipboard-manager nil)

  ;; Configure neotree
  (setq-default neo-theme 'icons)

  ;; Avoid jumping of echo-area height for long messages
  (setq-default message-truncate-lines t)

  ;; configure ycmd
  (setq-default ycmd-server-command (list "python" (file-truename "/code/ycmd/ycmd")))

  ;; Use nix-indent-line instead of indent-relative, as it works better
  (setq-default nix-indent-function 'nix-indent-line)
  )

(defun dotspacemacs//init-persp-frame-hook (frame &optional new-frame-p)
)

(defun dotspacemacs//dired-xdg-open ()
  (interactive)
  (dolist (file (dired-get-marked-files nil current-prefix-arg))
    (start-process "xdg-open" nil "xdg-open" file)))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq-default python-shell-completion-native-enable nil)
  (setq-default powerline-default-separator 'arrow)
  (remove-hook 'prog-mode-hook 'spacemacs//show-trailing-whitespace)

  (defvar spacemacs/python-interpreter-executable-history nil
    "History list for recently selected python interpreters.")

  (defun spacemacs/set-python-interpreter-executable (command)
    "Set the python interpreter for the current buffer to the given executable."
    (interactive
     (list
      (read-shell-command
       "Python interpreter: " nil 'python-interpreter-executable-history "python"
       )))
    (setq-local python-shell-interpreter command)
    (setq-local flycheck-python-pycompile-executable command)
    (flycheck-buffer)
    (let
        ((process (python-shell-get-process)))
      (when (and process (y-or-n-p "Python interpreter already running. Kill currently running process?"))
        (kill-process process))))
  (spacemacs/set-leader-keys-for-major-mode 'python-mode
    "sp" 'spacemacs/set-python-interpreter-executable)

  (evil-define-motion evil-sp-forward-sexp (count)
    (sp-forward-sexp count))

  (evil-define-motion evil-sp-backward-sexp (count)
    (sp-backward-sexp count))

  (evil-define-motion evil-sp-up-sexp (count)
    (sp-up-sexp count))

  (evil-define-motion evil-sp-down-sexp (count)
    (sp-down-sexp count))

  (define-key evil-normal-state-map "L" #'evil-sp-forward-sexp)
  (define-key evil-normal-state-map "H" #'evil-sp-backward-sexp)
  (define-key evil-normal-state-map "K" #'sp-kill-sexp)
  (define-key evil-normal-state-map "U" #'sp-backward-up-sexp)
  (define-key evil-normal-state-map "D" #'evil-sp-down-sexp)
  (define-key evil-normal-state-map "Q" #'evil-execute-macro)
  (define-key evil-normal-state-map "ä" #'spacemacs/evil-smart-doc-lookup)
  (define-key evil-normal-state-map "ü" #'spacemacs/jump-to-definition)

  (defun spacemacs/sp-get-sexp-around-point (count)
    (let*
        ((current-sexp (sp-get-sexp))
         (new-count (if (= (sp-get current-sexp :beg) (point)) (- count 1) count)))
      (if (= new-count 0) current-sexp (sp-get-enclosing-sexp new-count))))

  (evil-define-text-object evil-sp-a-sexp (count &rest other-args)
    "Text object for the enclosing sexp. With COUNT, use the COUNTth sexp up."
    (sp-get (spacemacs/sp-get-sexp-around-point count) (list :beg :end)))
  (define-key evil-outer-text-objects-map "f" #'evil-sp-a-sexp)

  (evil-define-text-object evil-sp-inner-sexp (count &rest other-args)
    "Text object for the enclosing sexp, without delimiters. With COUNT, use the COUNTth sexp up."
    (sp-get (spacemacs/sp-get-sexp-around-point count) (list :beg-in :end-in)))
  (define-key evil-inner-text-objects-map "f" #'evil-sp-inner-sexp)

  ;; these functions play nicer with existing indent modes,
  ;; especially haskell mode
  (defun spacemacs/evil-open-below (count)
    (interactive "p")
    (evil-start-undo-step)
    (evil-insert-state 1)
    (move-end-of-line nil)
    (setq evil-insert-vcount nil)
    (let ((enter-function (key-binding (kbd "RET"))))
      (dotimes (_ count) (call-interactively enter-function))))

  (defun spacemacs/evil-open-above (count)
    (interactive "p")
    (if (= (forward-line -1) 0)
        (spacemacs/evil-open-below count)
      (evil-start-undo-step)
      (evil-insert-newline-above)
      (setq evil-insert-vcount nil)
      (evil-insert-state 1)))

  ;; (define-key evil-normal-state-map "o" #'spacemacs/evil-open-below)
  ;; (define-key evil-normal-state-map "O" #'spacemacs/evil-open-above)

  ;; configure magithub to use the same token as the gh.el library
  (use-package gh
    :config
    (setq-default ghub-username (gh-auth-get-username))
    (setq-default ghub-token (gh-auth-get-oauth-token)))

  (setq-default compilation-read-command nil)
  (spacemacs/set-leader-keys "px" 'projectile-run-project)
  (spacemacs/set-leader-keys "p#" 'spacemacs/projectile-shell-pop)
  (spacemacs/set-leader-keys "#" 'spacemacs/default-pop-shell)

  (setq-default doc-view-continuous t)
  (setq-default persp-init-frame-behaviour #'dotspacemacs//init-persp-frame-hook)
  (setq-default persp-autokill-buffer-on-remove t)
  (setq-default magit-diff-refine-hunk t)

  ;; configure erc
  (setq-default erc-hide-list '("JOIN" "PART" "QUIT"))

  (with-eval-after-load 'org
    (load-file "~/.spacemacs.d/writeup-template.el")
    (setq templates '((writeup . org-template-writeup)))

    (defun hook-org-document-theme (plist backend)
      (let* ((template-name (org-entry-get nil "template" t))
             (template (and template-name (assq (intern template-name) templates))))
        (when template (org-combine-plists plist (funcall (cdr template) plist)))))
    (setq org-export-filter-options-functions nil)
    (add-to-list 'org-export-filter-options-functions #'hook-org-document-theme))

  (dtrt-indent-global-mode 1)

  ;; some c/c++ style customization
  (defun c-c++-style-hook ()
    (c-set-offset 'inlambda 0)
    (c-set-offset 'access-label '/))
  (add-hook 'c-mode-hook 'c-c++-style-hook)
  (add-hook 'c++-mode-hook 'c-c++-style-hook)

  (setq rainbow-identifiers-faces-to-override '(font-lock-variable-name-face font-lock-function-name-face))

  ;; after js2 mode finishes parsing, we want to update colors as fast as possible
  ;; to do so, call font-lock-flush which triggers rainbow identifier colors again
  (setq-default js2-parse-finished-hook '(font-lock-flush))

  ;; more keywords for org-mode
  (use-package org-projectile
    :config
    (message "org projectile config init.el")
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
     org-capture-templates
     `(,(org-projectile-project-todo-entry)
       ("t" "todo task" entry (file+headline "" "tasks") "** TODO %?" :prepend t)
       ("r" "reply task" entry (file+headline "" "tasks") "** REPLY %?" :prepend t)
       ("A" "Ascii mail" entry (file+headline "" "ascii") "** REPLY %?" :prepend t)
       ("a" "Ascii VoSI" entry (file+headline "" "VoSI TOPs") "*** %?"))
     org-todo-keyword-faces
     '(("TODO" . (:foreground "#cc9393" :background nil :weight bold))
       ("DONE" . (:foreground "#afd8af" :background nil :weight bold))
       ("NEXT" . (:foreground "#dca3a3" :background nil :weight bold)))))

  ;; workaround for https://debbugs.gnu.org/cgi/bugreport.cgi?bug=34341
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

  ;; dash config
  (setq dash-docs-browser-func 'eww)

  ;; dired additions
  (define-key dired-mode-map "ä" 'dired-xdg-open)

  (defun fix-mode-line (orig-fun)
    17)
  (advice-add 'spacemacs/compute-mode-line-height :around #'fix-mode-line)

  (with-eval-after-load 'tramp
    (let ((sshx (assoc "sshx" tramp-methods)))
      (add-to-list 'tramp-methods `("s" . ,(cdr sshx)))
      (add-to-list 'tramp-default-proxies-alist '("\\`wmf\\'" "\\`tools.*" "/ssh:wmf:"))))

  (setq-default TeX-view-program-selection
                '(((output-dvi has-no-display-manager)
                   "dvi2tty")
                  ((output-dvi style-pstricks)
                   "dvips and gv")
                  (output-dvi "xdvi")
                  (output-pdf "PDF Tools")
                  (output-html "xdg-open")))
  (eval-after-load "tex" '(add-to-list 'TeX-command-list '("Make" "make" TeX-run-compile nil t)))
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
  )
