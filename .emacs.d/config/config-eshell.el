 (defmacro with-face (str &rest properties)
    `(propertize ,str 'face (list ,@properties)))

(defun shk-eshell-prompt ()
  (concat
   (with-face (eshell/pwd) :foreground "lightblue")
   (if (= (user-uid) 0)
       (with-face " #" :foreground "red")
     " $")
   " "))

(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)

(provide 'config-eshell)
