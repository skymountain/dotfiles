(require 'omake-mode)
(define-keybinds global-map
  '(("M-P" omake-previous-error)
    ("M-N" omake-next-error)
    ("M-o" omake-round-visit-buffer)
    ("M-O" omake-run)
    ))