(require 'proof-site)

(add-to-list 'ac-modes 'coq-mode)
(setq auto-mode-alist
      (assoc-delete-by-value auto-mode-alist 'hol-light-mode))

(custom-set-variables
 '(proof-electric-terminator-enable t)
 )

(add-hook 'proof-mode-hook
          (lambda ()
            (global-keybinds-define-keybinds proof-mode-map)
            (define-keybinds proof-mode-map
              '(("M-e" proof-goto-command-end)
                ("M-a" proof-goto-command-start)
                ("C-c C-p" proof-process-buffer)
                ("C-c p" proof-prf)
                ("C-c RET" proof-goto-point)
                ))
            ))
