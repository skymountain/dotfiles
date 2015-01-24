; haskell-mode
(require 'haskell-mode)
(require 'ghc)

(add-hook 'haskell-mode-hook
          (lambda ()
            (turn-on-haskell-indentation)
            (turn-on-haskell-decl-scan)
            (define-keybinds haskell-mode-map
              '(("C-," haskell-move-nested-left)
                ("C-." haskell-move-nested-right)
                ("C-c t" haskell-doc-show-type)
                ("C-c C-c" compile)
                ))

            (ghc-init)
            (flymake-mode)
            (message "TEST")
            ))
