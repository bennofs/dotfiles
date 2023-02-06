;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom install'
;; will do this for you). The `doom!' block below controls what modules are
;; enabled and in what order they will be loaded. Remember to run 'doom refresh'
;; after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.
;;

;; Set custom file to a different file so it can be ignored by git
;; (setq custom-file (concat (dir!) "/customize.el"))
;; (when (file-exists-p custom-file) (load custom-file))

(setq-default lsp-clients-digestif-executable "/home/.luarocks/bin/digestif")

(doom! :completion
       company              ; the ultimate code completion backend
       ivy                  ; a search engine for love and life

       :ui
       doom                 ; what makes DOOM look the way it does
       doom-dashboard       ; a nifty splash screen for Emacs
       hl-todo              ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra                ; "microstates"
       modeline             ; snazzy, Atom-inspired modeline, plus API
       nav-flash            ; blink the current line after jumping
       ophints              ; highlight the region an operation acts on
       (popup               ; tame sudden yet inevitable temporary windows
        +all                ; catch all popups that start with an asterix
        +defaults)          ; default popup rules
       (treemacs +lsp)      ; a project drawer, like neotree but cooler
       vc-gutter            ; vcs diff in the fringe
       vi-tilde-fringe      ; fringe tildes to mark beyond EOB
       window-select        ; visually switch windows
       zen                  ; write without distraction

       :editor
       (evil +everywhere)   ; come to the dark side, we have cookies
       file-templates       ; auto-snippets for empty files
       fold                 ; (nigh) universal code folding
       format
       multiple-cursors     ; editing in many places at once
       rotate-text          ; cycle region at point between text candidates
       snippets             ; my elves. They type so I don't have to

       :emacs
       dired      ; making dired pretty [functional]
       electric             ; smarter, keyword-based electric-indent
       ibuffer              ; interactive buffer management
       undo
       vc                   ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; a consistent, cross-platform shell (WIP)
       ;;shell             ; a terminal REPL for Emacs
       ;;term              ; terminals in Emacs
       ;;vterm             ; another terminals in Emacs

       :tools
       ansible
       biblio
       direnv
       docker
       editorconfig         ; let someone else argue about tabs vs spaces
       (eval +overlay)      ; run code, run (also, repls)
       gist                 ; interacting with github gists
       (lookup              ; helps you navigate your code and documentation
        +docsets)           ; ...or in Dash docsets locally
       lsp
       (magit +forge)       ; a git porcelain for Emacs
       pdf                  ; pdf enhancements

       :checkers
       (syntax +childframe) ; tasing you for every semicolon you forget
       ;spell                ; tasing you for misspelling mispelling TODO: disabled due to perf issues

       :lang
       (cc +lsp)            ; C/C++/Obj-C madness
       coq
       csharp
       data                 ; config/data formats
       emacs-lisp           ; drown in parentheses
       (haskell +lsp)       ; a language that's lazier than I am
       go                   ; the hipster dialect
       (java +lsp)          ; the poster child for carpal tunnel syndrome
       javascript           ; all(hope(abandon(ye(who(enter(here))))))
       kotlin               ; a better, slicker Java(Script)
       latex                ; writing papers in Emacs has never been so fun
       ledger               ; money, money
       lua                  ; one-based indices? one-based indices
       markdown             ; writing docs for people to ignore
       nim                  ; python + lisp at the speed of c
       nix                  ; I hereby declare "nix geht mehr!"
       ocaml                ; an objective camel
       (org                 ; organize your plain life in plain text
        +dragndrop          ; drag & drop files/images into org buffers
        +ipython            ; ipython/jupyter support for babel
        +pandoc             ; export-with-pandoc support
        +pomodoro
        +present)           ; using org-mode for presentations
       raku                 ; write code no one else can comprehend
       (python +lsp +pyright) ; beautiful is better than ugly
       racket               ; a DSL for DSLs
       ruby                 ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)          ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       sh                   ; she sells {ba,z,fi}sh shells on the C xor
       yaml
       web                  ; the tubes

                            ;; The default module sets reasonable defaults for Emacs. It also
                            ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
                            ;; config. Use it as a reference for your own modules.
       :config
       (default +bindings +smartparens))
