(set-face-attribute 'default nil
  :stipple nil
  :inverse-video nil
  :box nil
  :strike-through nil
  :overline nil
  :underline nil
  :slant 'normal
  :weight 'normal
  :height 90
  :width 'normal
  :font "Source Code Pro for Powerline"
)

(set-face-attribute 'mode-line nil
		    :foreground "#ddd6d3"
                    :background "#2aa198"
		    :underline nil
                    :box nil)

(set-face-attribute 'mode-line-buffer-id nil
		    :foreground "#ddd6d3"
		    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :box nil)

(set-face-attribute 'powerline-active1 nil
		    :background "#073642"
		    :box nil
)

(set-face-attribute 'powerline-active2 nil
		    :background "#002b36"
		    :box nil
)

(set-face-attribute 'powerline-inactive1 nil
		    :background "#073642"
		    :box nil
)

(set-face-attribute 'powerline-inactive2 nil
		    :background "#002b36"
		    :box nil
)

(provide 'config-faces)
