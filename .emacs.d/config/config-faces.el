(set-face-attribute 'default nil 
  :stipple nil
  :background "#000C0C"
  :foreground "#F9F9F9"
  :inverse-video nil
  :box nil
  :strike-through nil
  :overline nil
  :underline nil
  :slant 'normal
  :weight 'normal
  :height 95
  :width 'normal
  :font "Inconsolata-dz for Powerline"
)

(set-face-attribute 'mode-line nil
  :background "grey75"
  :foreground "black"
  :box '(:line-width -1 :style released-button)
  :height 0.9
)

(provide 'config-faces)
