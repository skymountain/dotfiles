; aspell
(custom-set-variables
  '(ispell-program-name "aspell")
  )
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

(setq flyspell-mode-hook-list '(text-mode-hook))

(define-keybinds global-map
  '(("C-<tab>" ispell-complete-word)
    ("C-:"     flyspell-auto-correct-previous-word)
    ))

; sdic
(autoload 'sdic-describe-word "sdic" "look up for meanings of a word." t nil)
(autoload 'sdic-describe-word-at-point "sdic" "look up for meanings of a word on a cursor." t nil)

(define-keybinds global-map
  '(("C-c C-w" sdic-describe-word)
    ("C-c w"    sdic-describe-word-at-point)
  ))

(setq sdic-eiwa-dictionary-list
      '((sdicf-client "~/.emacs.d/conf/sdic/eijiro.sdic")))
(setq sdic-waei-dictionary-list
      '((sdicf-client "~/.emacs.d/conf/sdic/waeijiro.sdic")))
(setq sdic-default-coding-system 'utf-8-unix)
