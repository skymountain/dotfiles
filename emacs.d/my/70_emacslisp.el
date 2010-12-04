; auto-install
(require 'auto-install)
(custom-set-variables
  '(ediff-window-setup-function (quote ediff-setup-windows-plain))
  )

(defun install-elisp-list-from (from entries)
  (while entries
    (funcall from (car entries))
    (setq entries (cdr entries))))
(defun install-elisp-list-from-emacswiki (files)
  (install-elisp-list-from 'auto-install-from-emacswiki files))
(defun install-elisp-list-from-url (urls)
  (install-elisp-list-from 'auto-install-from-url urls))
(defun install-elisp-list-by-batch (batches)
  (install-elisp-list-from 'auto-install-batch batches))

(defun upgrade-all-elispes ()
  "Upgrade all installed elispes"
  (interactive)
  (install-elisp-list-from-emacswiki
   '("auto-install.el"
     "mic-paren.el"
     "point-undo.el"
     "color-moccur.el"
     "moccur-edit.el"
     "auto-async-byte-compile.el"))
  (install-elisp-list-from-url
   '("http://www.wonderworks.com/download/filladapt.el"
     "http://people.debian.org/~psg/elisp/font-latex.el"
     "http://www.gentei.org/~yuuji/software/windows.el"
     "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el"))
  (install-elisp-list-by-batch
   '("auto-complete"
     "anything")))

; automatic byte compile
(require 'auto-async-byte-compile)
(custom-set-variables
  '(auto-async-byte-compile-exclude-files-regexp
    (regexp-quote (expand-file-name "~/.emacs.d/init.el")))
  )
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
