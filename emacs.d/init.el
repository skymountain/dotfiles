(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (normal-top-level-add-subdirs-to-load-path))

(require 'init-loader)

(custom-set-variables
  '(init-loader-show-log-after-init nil)
  '(init-loader-default-regexp "\\(?:^[[:digit:]]\\{2\\}\\).*\\.elc?$")
  )
(defadvice init-loader-error-log (before enable-showing-init-loader-error-log activate)
  (custom-set-variables
    '(init-loader-show-log-after-init t)
    ))
(init-loader-load (expand-file-name "~/.emacs.d/my"))