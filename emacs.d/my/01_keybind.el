; define keybinds
(defun* make-keybinds (keybinds &key (prefix ""))
  (let ((prefix (if (string= "" prefix) prefix (concat " " prefix))))
    (mapcar
     (lambda (keybind)
       (cons (eval `(kbd ,(concat prefix (car keybind)))) (cadr keybind)))
     keybinds)))
 
(defun* define-keybinds (map binds &key (prefix ""))
  (let ((keybinds (make-keybinds binds :prefix prefix)))
    (mapc (lambda (keybind)
            (define-key map (car keybind) (cdr keybind)))
          keybinds)))

(require 'syntax-subword)
(syntax-subword-mode 1)
(setq syntax-subword-skip-spaces 'consistent)

(defun global-keybinds-define-keybinds (map)
  (let ((global-keybinds
         '(("C-j"     backward-char)
           ("M-j"     syntax-subword-backward)
           ("C-h"     delete-backward-char)
           ("M-h"     syntax-subword-backward-kill)
           ("M-f"     syntax-subword-forward)

           ("M-m"     mark-defun)
           ("C-c C-b" beginning-of-buffer)
           ("C-c C-e" end-of-buffer)
           ("C-x p"   (lambda () (interactive) (other-window -1)))
           ("C-m"     newline-and-indent)
           ("C-c C-j" goto-line)
           )))
    (define-keybinds map global-keybinds)))

; prefix key

;; for help command
(define-prefix-command 'help-prefix-map)

(define-keybinds global-map
  '(("C-M-h" help-prefix-map)
    ))

(define-keybinds help-prefix-map
  '(("f" describe-function)
    ("v" describe-variable)
    ("b" describe-bindings)
    ("k" describe-key)
    ))
