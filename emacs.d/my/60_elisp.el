; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (define-inheritated-keybinds lisp-interaction-mode-map)
            ))
