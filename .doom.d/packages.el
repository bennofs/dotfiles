;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! org-projectile :pin "642b39c698db00bc535c1c2335f425fb9f4855a9")
(package! eziam-themes :pin "5bec687a692331f7d8e1fe012817d66c40234bad")
(package! rainbow-identifiers :pin "19fbfded1baa98d12335f26f6d7b20e5ae44ce2e")
(package! diredc :pin "7ee68f6b1c87f8ab86cf23416472747e88860717")
(package! clean-aindent-mode :pin "a97bcae8f43a9ff64e95473e4ef0d8bafe829211")
(package! promela-mode :recipe (:host github :repo "rudi/promela-mode") :pin "905559f430f16e16cd12dac40b59f5b613c026fc")
(package! org-present :recipe (:host github :repo "rlister/org-present") :pin "4ec04e1b77dea76d7c30066ccf3200d2e0b7bee9")
(package! centered-window-mode :recipe (:host github :repo "anler/centered-window-mode") :pin "f50859941ab5c7cbeaee410f2d38716252b552ac")
(package! epresent :recipe (:host github :repo "eschulte/epresent") :pin "77ead97419092eccb35f2ba1710cb4a5bd8be86b")
(package! hide-lines
  :recipe
  (:host github
   :repo "emacsmirror/emacswiki.org"
   :branch "master"
   :files ("hide-lines.el"))
  :pin "eeb872f536ff5d65cfee36076838a5c5a832d4f1")
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
(package! graphviz-dot-mode :pin "3642a0a5f41a80c8ecef7c6143d514200b80e194")
(package! filetags :pin "01e6a919507a832ee001a2a0fc257657f8b04b72")
(package! disk-usage :pin "8792032bb8e7a6ab8a8a9bef89a3964e67bb3cef")
(package! trashed :pin "ddf5830730544435a068f2dc9ac75a81ea69df1d")
(package! date2name  :pin "386dbe73678705d6107cd5c9bdeb4f7c97632360")
(package! d-mode :pin "024aca97d07e72bf3500fb6bf0cdf50c4992a741")
