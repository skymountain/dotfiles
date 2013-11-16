; http://www.bookshelf.jp/soft/meadow_30.html#SEC404
(setq win:switch-prefix (kbd "M-z"))
(define-key global-map win:switch-prefix nil)
(define-key global-map (kbd "M-z 1") 'win-switch-to-window)

; window/frame
(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map (kbd "C") 'see-you-again)

(require 'popwin)
(popwin-mode 1)
(define-keybinds global-map
  '(("M-p" popwin:popup-buffer )
    ))

;; (setq display-buffer-function 'popwin:display-buffer)
