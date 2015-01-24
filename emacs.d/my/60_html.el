(add-hook 'sgml-mode-hook
          (lambda ()
            (global-keybinds-define-keybinds sgml-mode-map)
            (define-keybinds sgml-mode-map
              '(("C-c e" sgml-close-tag
                 )))
            ))
