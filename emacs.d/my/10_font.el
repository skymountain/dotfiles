(add-to-list 'default-frame-alist '(font . "Consolas"))
(cond
 (window-system
  (set-default-font "Consolas")
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("IPAMonaGothic" . "unicode-bmp"))))