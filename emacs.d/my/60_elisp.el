; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (global-keybinds-define-keybinds lisp-interaction-mode-map)
            ))
