(require 'anything-startup)
(anything-read-string-mode '(stirng buffer variable command))
(custom-set-variables
  '(descbinds-anything-window-style (quote split-window)))

(define-keybinds anything-map
  '(("M-n" anything-next-source)
    ("M-p" anything-previous-source)
    ))

(require 'anything-c-moccur)
(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)

(define-keybinds global-map
  '(("M-l" anything-for-files)
    ("M-y" anything-show-kill-ring)
    ("M-s" anything-c-moccur-occur-by-moccur)
    ))
