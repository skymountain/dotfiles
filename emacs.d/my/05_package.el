(custom-set-variables
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ))
 )
(package-initialize)

(require 'cl)
(mapcar (lambda (p)
          (when (not (package-installed-p p))
            (package-install p)))
        '(anything
          auto-complete
          color-moccur
          color-theme
          flymake-cursor
          gtags
          haskell-mode
          mic-paren
          perl-completion
          point-undo
          popup
          popwin
          pretty-lambdada
          revive
          rust-mode
          scheme-complete
          session
          shell-pop
          tuareg
          undo-tree
          zlc
          ))
