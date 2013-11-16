(custom-set-variables
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ))
 )
(package-initialize)

(defvar required-package-list
  '(anything
    auto-complete
    color-moccur
    color-theme
    flymake-cursor
    gtags
    haskell-mode
    magit
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
    yaml-mode
    zlc
    ))

(require 'cl)

(let ((not-installed (loop for x in required-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))
