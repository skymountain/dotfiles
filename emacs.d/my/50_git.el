(when (require 'magit nil t)
  (define-keybinds
    global-map
    '(("s" magit-status)
      ("l" magit-log)
      ("b" magit-branch-manager)
      ("p" magit-push))
    :prefix "C-c g")
  )
