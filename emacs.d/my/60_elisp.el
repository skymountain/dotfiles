; lisp-interaction-mode-hook
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (define-inheritated-global-keybinds lisp-interaction-mode-map)
            ))
