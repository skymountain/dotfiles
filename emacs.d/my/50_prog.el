; flymake
(require 'flymake)
(defun flymake-display-err-minibuf () 
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((err        (nth (1- count) line-err-info-list))
               (file       (flymake-ler-file err))
               (full-file  (flymake-ler-full-file err))
               (text       (flymake-ler-text err))
               (line       (flymake-ler-line err)))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))
(global-set-key (kbd "C-c d") 'flymake-display-err-minibuf)

(defun flymake-make-init (candidate-list)
  `(lambda ()
     (let ((use-method nil))
       (dolist (candidate (quote ,candidate-list))
         (let ((pred   (car candidate))
               (method (cdr candidate)))
           (when (and (not use-method) (funcall pred))
             (setq use-method method))))
       (if use-method
           (funcall use-method)
           (message "There is no function for flymake init.")))))

(defun flymake-add-allowed-file-name-masks (mask func)
  (push `(,mask ,func) flymake-allowed-file-name-masks))

(defun flymake-make-init-on-the-fly (program flags)
  `(lambda ()
     (let* ((tmp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
            (local-file (file-relative-name
                         tmp-file
                         (file-name-directory buffer-file-name)))
            (args (append (quote ,flags) (list tmp-file))))
       (list ,program args))))

; auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/conf/auto-complete")
(ac-config-default)
(define-keybinds ac-completing-map
  '(("C-n" ac-next)
    ("C-p" ac-previous)
    ))
(custom-set-variables
  '(ac-auto-show-menu 0.5)
  )

; etc.
(which-func-mode 1)
