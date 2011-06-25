(add-hook 'help-mode-hook
          (lambda ()
            (define-keybinds help-mode-map
              '(("B" help-go-back)
                ("F" help-go-forward)
                ))
            ))
