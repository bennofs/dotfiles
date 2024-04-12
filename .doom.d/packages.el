;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! org-projectile :pin "bf1c30b750020ab8dd634dd66b2c7b76c56286c5")
(package! eziam-themes :pin "8223acc0218130ad2493c1476ad3736ee4fdbb8f")
(package! rainbow-identifiers :pin "19fbfded1baa98d12335f26f6d7b20e5ae44ce2e")
(package! diredc :pin "d99b51de2bc56cb779b1e3dde6b46e0e9cc0d2a6")
(package! clean-aindent-mode :pin "a97bcae8f43a9ff64e95473e4ef0d8bafe829211")
(package! promela-mode :recipe (:host github :repo "rudi/promela-mode") :pin "905559f430f16e16cd12dac40b59f5b613c026fc")
(package! org-present :recipe (:host github :repo "rlister/org-present") :pin "4ec04e1b77dea76d7c30066ccf3200d2e0b7bee9")
(package! centered-window-mode :recipe (:host github :repo "anler/centered-window-mode") :pin "80965f6c6afe8d918481433984b493de72af5399")
(package! epresent :recipe (:host github :repo "eschulte/epresent") :pin "77ead97419092eccb35f2ba1710cb4a5bd8be86b")
(package! hide-lines
  :recipe
  (:host github
   :repo "emacsmirror/emacswiki.org"
   :branch "master"
   :files ("hide-lines.el"))
  :pin "9e367200dae7a851c42fb130ccfb9bf667227495")
(package! smali-mode
  :recipe
  (:host github
   :repo "strazzere/Emacs-Smali"
   :branch "master"
   :files ("smali-mode.el")) :pin "16c50ca2ab3159fb9f2d9b938ab7cbbf860bd14f")
(package! pasp-mode
  :recipe
  (:host github
   :repo "santifa/pasp-mode"
   :branch "master")
  :pin "59385eb0e8ebcfc8c11dd811fb145d4b0fa3cc92")
(package! graphviz-dot-mode :pin "8ff793b13707cb511875f56e167ff7f980a31136")
(package! filetags :pin "01e6a919507a832ee001a2a0fc257657f8b04b72")
(package! disk-usage :pin "2dde49524ad328dd152557b2f0104255ce19eeff")
(package! trashed :pin "52a52a363ce53855790e7a59aed6976eec18c9ea")
(package! date2name  :pin "386dbe73678705d6107cd5c9bdeb4f7c97632360")
(package! d-mode :pin "156450fa7a864e4cb92c18e4dd4ffd6a0fae0f63")
(package! company-nixos-options :disable t)
(package! lsp-ltex :pin "c447813af03322bab98d59b02aad81ecdf0c5b32")
(package! vala-mode :pin "d696a8177e94c81ea557ad364a3b3dcc3abbc50f")
(package! dired-du :pin "e28bf1e4fdd051f8f5355ed510424278bfe90e0f")
