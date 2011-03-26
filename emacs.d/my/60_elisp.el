; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (define-keybinds-defined-in-global lisp-interaction-mode-map)
            ))
