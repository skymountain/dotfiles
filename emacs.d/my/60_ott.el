(require 'ottmode)

(defvar ott-mode-map (make-keymap))
(set-keymap-parent ott-mode-map global-map)

(defun ott-execute-external-command (command &rest args)
  (let ((buffer (get-buffer-create "*ott*")))
    (with-current-buffer buffer (erase-buffer))
    (eval (append '(call-process command nil buffer nil) args))))

(defun ott-to-tex ()
  (interactive)
  (let ((filename (buffer-file-name))
        (script (expand-file-name "~/.emacs.d/script/tex/ott-to-tex.sh")))
    (ott-execute-external-command script filename)))

(add-hook 'ott-mode-hook
          (lambda ()
            (use-local-map ott-mode-map)
            (define-keybinds ott-mode-map
              '(("C-c C-c" ott-to-tex)
                ))
            ))
