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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.5)
 '(anything-gtags-enable-initial-pattern t)
 '(auto-insert-directory (expand-file-name "~/.emacs.d/conf/template"))
 '(compilation-window-height 10)
 '(cperl-invalid-face nil)
 '(descbinds-anything-window-style 'split-window)
 '(dmoccur-exclusion-mask
   (append
    '("\\.elc$" "\\.exe$" "\\.dll$" "\\.lib$" "\\.lzh$" "\\.zip$" "\\.deb$" "\\.gz$" "\\.pdf$" "\\.tar$" "\\.gz$" "\\.7z$" "\\.o$" "\\.a$" "\\.mod$" "\\.nc$" "\\.obj$" "\\.ai$" "\\.fla$" "\\.swf$" "\\.dvi$" "\\.pdf$" "\\.bz2$" "\\.tgz$" "\\.cab$" "\\.sea$" "\\.bin$" "\\.fon$" "\\.fnt$" "\\.scr$" "\\.tmp$" "\\.wrl$" "\\.Z$" "\\.aif$" "\\.aiff$" "\\.mp3$" "\\.wma$" "\\.mpg$" "\\.mpeg$" "\\.aac$" "\\.mid$" "\\.au$" "\\.avi$" "\\.dcr$" "\\.dir$" "\\.dxr$" "\\.midi$" "\\.mov$" "\\.ra$" "\\.ram$" "\\.vdo$" "\\.wav$" "\\.doc$" "\\.xls$" "\\.ppt$" "\\.mdb$" "\\.adp$" "\\.wri$" "\\.jpg$" "\\.gif$" "\\.tiff$" "\\.tif$" "\\.bmp$" "\\.png$" "\\.pbm$" "\\.jpeg$" "\\.xpm$" "\\.pbm$" "\\.ico$" "\\.eps$" "\\.psd$" "/TAGS$" "\\~$" "\\.svn/.+" "CVS/.+" "\\.git/.+")
    '("\\.omc$")))
 '(echo-keystrokes 0.1)
 '(enable-recursive-minibuffers t)
 '(fill-column 80)
 '(gtags-path-style 'relative)
 '(history-length 1000)
 '(ido-enable-flex-matching t)
 '(ido-ignore-files
   (append
    '("\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./")
    '("\\.omc$")))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(init-loader-default-regexp "\\(?:^[[:digit:]]\\{2\\}\\).*\\.elc?$")
 '(init-loader-show-log-after-init nil)
 '(ispell-program-name "aspell")
 '(js-indent-level 2)
 '(moccur-split-word t)
 '(package-selected-packages '(tree-sitter syntax-subword queue merlin compat))
 '(paragraph-start "^\\([ 　・○<	
]\\|(?[0-9a-zA-Z]+)\\)")
 '(paren-sexp-mode t)
 '(shell-pop-shell-type
   '("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell))))
 '(shell-pop-term-shell nil)
 '(tab-width 2)
 '(transient-mark-mode t)
 '(truncate-partial-width-windows nil)
 '(uniquify-buffer-name-style 'post-forward-angle-brackets nil (uniquify))
 '(uniquify-ignore-buffers-re "*[^*]+*")
 '(use-dialog-box nil))

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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
