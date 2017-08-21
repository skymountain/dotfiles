(defvar required-package-list
  '(anything
    ;; anything-c-moccur
    auctex
    auto-complete
    color-moccur
    color-theme
    ddskk
    dired-hacks
    dired-details
    dired-details+
    elpy
    filladapt
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
    smartparens
    syntax-subword
    switch-window
    tuareg-mode
    undo-tree
    undohist
    whitespace
    windows
    yaml-mode
    yatex
    zlc
    ))

(dolist (x required-package-list)
  (eval `(el-get-bundle ,x)))
