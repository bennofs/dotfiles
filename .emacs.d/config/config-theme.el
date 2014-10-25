(setq custom-safe-themes '(
  "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" ; sml-respectful
  "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" ; solarized-light
  "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" ; solarized-dark
  default))
(setq ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])

(load-theme 'solarized-dark)
(add-hook 'after-init-hook '(lambda ()
  (set-face-attribute 'default nil  :background "#000e16")
  (set-face-attribute 'fringe nil :background "#000e16")
  (set-face-attribute 'linum  nil :background "#000e16")
  (set-face-attribute 'mode-line-inactive nil :background "#000e16" :underline nil)
  (set-face-attribute 'mode-line nil :background "#001e30" :underline nil)
))

(provide 'config-theme)
