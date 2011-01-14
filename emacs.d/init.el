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

(defadvice init-loader--re-load-files
  (after init-loader--re-load-files-filter activate)
  (let* ((filter (lambda (func xs)
                   (let ((tmp-list ()))
                     (dolist (x xs (reverse tmp-list))
                       (when (funcall func x)
                         (setq tmp-list (cons x tmp-list)))))))
         (el-with-elc
          (mapcar (lambda (el) (replace-regexp-in-string "\\.elc$" ".el" el t))
                  (funcall filter (lambda (el) (string-match "\\.elc$" el))
                           ad-return-value))))
    (setq ad-return-value (funcall filter (lambda (el) (not (member el el-with-elc))) ad-return-value))))

(init-loader-load (expand-file-name "~/.emacs.d/my"))