(require 'omake-mode)

(setq omake-sound-allow nil)

(define-keybinds global-map
  '(("M-P" omake-previous-error)
    ("M-N" omake-next-error)
    ("M-o" omake-round-visit-buffer)
    ("M-O" omake-run)
    ))

(add-to-list 'auto-mode-alist '("^OMakefile$" . omake-mode))
(add-to-list 'auto-mode-alist '("^OMakeroot$" . omake-mode))
(call-function-in-group 'ignore-files-by-regexp-list
                        "\\.omc$")
