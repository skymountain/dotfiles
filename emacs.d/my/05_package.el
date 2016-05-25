(defvar required-package-list
  '(anything
    anything-c-moccur
    auto-complete
    color-moccur
    color-theme
    ddskk
    flymake-cursor
    ghc
    gtags
    haskell-mode
    magit
    merlin
    mic-paren
    moccur-edit
    ocp-indent
    perl-completion
    point-undo
    popup
    popwin
    pretty-lambdada
    ; proof-general
    revive
    rust-mode
    scheme-complete
    session
    shell-pop
    syntax-subword
    tuareg-mode
    undo-tree
    windows
    yaml-mode
    yatex
    zlc
    ))

(dolist (x required-package-list)
  (eval `(el-get-bundle ,x)))
