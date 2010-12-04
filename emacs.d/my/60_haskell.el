; haskell-mode
(require 'haskell-ghci)
(load "haskell-site-file")
(add-hook 'haskell-mode-hook
          (lambda ()
	    (turn-on-haskell-ghci)
	    (capitalized-words-mode t)
	    (turn-on-haskell-doc-mode)
	    (turn-on-haskell-indentation)
	    ; (turn-on-haskell-indent)
	    ; (turn-on-haskell-simple-indent)
	    ))

(define-keybinds global-map 
  '(("C-c C-h" haskell-ghci-show-ghci-buffer)
    ))