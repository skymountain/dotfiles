(require 'omake-mode)

(setq omake-sound-allow nil)

(define-keybinds global-map
  '(("M-P" omake-previous-error)
    ("M-N" omake-next-error)
    ("M-o" omake-round-visit-buffer)
    ("M-O" omake-run)
    ))

(call-function-in-group 'ignore-files-by-regexp-list
                        "\\.omc$")
