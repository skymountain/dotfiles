
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(require 'cl-lib)
(defun concat-path (&rest segs)
  (when segs
    (cl-reduce '(lambda (x y) (concat (file-name-as-directory x) y))
	       segs)))

(let ((default-directory (locate-user-emacs-file "el-get")))
  (add-to-list 'load-path
               (concat-path default-directory "el-get"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path (locate-user-emacs-file "site-lisp"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (create-file-buffer "*installing el-get*")
    (load-file (locate-user-emacs-file "el-get-install.el"))
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle init-loader)

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
