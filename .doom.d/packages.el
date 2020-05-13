;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! org-projectile :pin "de37d00947")
(package! eziam-theme :pin "9ae0fdb2ad")
(package! tao-theme :pin "d5b9693fca")
(package! rainbow-identifiers :pin "19fbfded1b")
(package! clean-aindent-mode :pin "a97bcae8f4")
(package! promela-mode :recipe (:host github :repo "rudi/promela-mode") :pin "5974a15221")
(package! org-present :recipe (:host github :repo "rlister/org-present") :pin "9709ca2d04")
(package! centered-window-mode :recipe (:host github :repo "anler/centered-window-mode") :pin "24f7c5be9d")
(package! hide-lines
  :recipe
  (:host github
         :repo "emacsmirror/emacswiki.org"
         :branch "master"
         :files ("hide-lines.el"))
  :pin "291bc4cbb7")
(package! graphviz-dot-mode :pin "0a4197d1c2")
(unpin! lsp-mode)
