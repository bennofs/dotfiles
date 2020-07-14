;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! org-projectile :pin "96a57a43555e24e5e0d81e79f0fbb47001c41bac")
(package! eziam-theme :pin "7a585de01b6fee081eaa167b09d7e12d02cf4149")
(package! rainbow-identifiers :pin "19fbfded1baaa98d12335f26f6d7b20e5ae44c")
(package! clean-aindent-mode :pin "a97bcae8f43a9ff64e95473e4ef0d8bafe829211")
(package! promela-mode :recipe (:host github :repo "rudi/promela-mode") :pin "5974a15221720fdb4eb825da01282289badc4884")
(package! org-present :recipe (:host github :repo "rlister/org-present") :pin "9709ca2d04a59959354222ac4d3f8b750785739a")
(package! centered-window-mode :recipe (:host github :repo "anler/centered-window-mode") :pin "f50859941ab5c7cbeaee410f2d38716252b552ac")
(package! hide-lines
  :recipe
  (:host github
         :repo "emacsmirror/emacswiki.org"
         :branch "master"
         :files ("hide-lines.el"))
  :pin "71c83103117e7c07bfb100628e04c53c4cd42a06")
(package! graphviz-dot-mode :pin "3642a0a5f41a80c8ecef7c6143d514200b80e194")
(unpin! lsp-mode)
