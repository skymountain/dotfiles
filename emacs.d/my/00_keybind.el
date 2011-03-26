(defun make-keybinds (keybinds)
  (mapcar
   (lambda (keybind)
     (cons (eval `(kbd ,(car keybind))) (cadr keybind)))
   keybinds))
 
(defun define-keybinds (map binds)
  (let ((keybinds (make-keybinds binds)))
    (mapc (lambda (keybind)
            (define-key map (car keybind) (cdr keybind)))
          keybinds)))

(require 'camelCase)
(camelCase-mode 1)

(defun define-keybinds-defined-in-global (map)
  (let ((global-keybinds
	 '(("C-j"     backward-char)
	   ("M-j"     camelCase-backward-word)
	   ("C-h"     delete-backward-char)
	   ("M-h"     camelCase-backward-kill-word)
	   ("C-c C-b" beginning-of-buffer)
	   ("C-c C-e" end-of-buffer)
	   ("C-x p"   (lambda () (interactive) (other-window -1)))
	   ("C-m"     newline-and-indent)
	   ("C-c C-j" goto-line)
	   )))
    (define-keybinds map global-keybinds)))

(define-keybinds-defined-in-global global-map)
