(when (require 'proof-site nil 'noerror)

  (add-to-list 'ac-modes 'coq-mode)

  (add-hook 'coq-mode-hook
            (lambda ()
              (define-keybinds coq-keymap
                '(("p" coq-show-proof)
                  ))))
)
