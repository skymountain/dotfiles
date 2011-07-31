(require 'js)

(custom-set-variables
 `(js-indent-level ,tab-width)
 )
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(global-keybinds-define-keybinds js-mode-map)

; flymake
(defun flymake-javascript-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace)))
    (list (expand-file-name "~/.emacs.d/script/flymake/javascript_flycheck.js")
          (append (mapcar (lambda (opt) (format "--%s" opt))
                           flymake-javascript-bool-options)
                   (mapcar (lambda (var) (format "--predef=%s" var))
                           flymake-javascript-predefined-variables)
                   (list temp-file)))))

(defvar flymake-javascript-bool-options ())
(defvar flymake-javascript-predefined-variables ())

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.js$" flymake-javascript-init))

(add-to-list 'flymake-err-line-patterns
             '("\\(.+\\.js\\):\\([[:digit:]]+\\):\\([[:digit:]]+*\\):\\(.+\\)$" 1 2 3 4))

(setq flymake-javascript-bool-options
      '("node"
        "eqeqeq"
        "eqnull"
        "globalstrict"
        "latedef"
        "noarg"
        "noempty"
        "undef"
        "trailing"
        ))

(setq flymake-javascript-predefined-variables
      '("console"
        ))

(add-hook 'js-mode-hook
          (lambda ()
            (flymake-mode 1)
            ))
