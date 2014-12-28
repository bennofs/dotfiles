(setq custom-safe-themes t)
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
