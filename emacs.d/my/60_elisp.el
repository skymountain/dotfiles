; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (global-keybinds-define-keybinds lisp-interaction-mode-map)
            (define-keybinds lisp-interaction-mode-map
              '(("C-M-h f" describe-function)
                ("C-M-h v" describe-variable)
                ("C-M-h b" describe-bindings)
                ("C-M-h k" describe-key)
                ))
            ))
