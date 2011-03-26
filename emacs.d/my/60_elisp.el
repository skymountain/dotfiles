; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (define-inherited-global-keybinds lisp-interaction-mode-map)
            ))
