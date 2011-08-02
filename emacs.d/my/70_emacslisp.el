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
     "anything-gtags.el"
     "ipa.el"
     ))
  (install-elisp-list-from-url
   '("http://www.wonderworks.com/download/filladapt.el"
     "http://people.debian.org/~psg/elisp/font-latex.el"
     "http://www.gentei.org/~yuuji/software/windows.el"
     "http://www.gentei.org/~yuuji/software/revive.el"
     "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el"
     "http://www.eecs.ucf.edu/~leavens/emacs/camelCase/camelCase-mode.el"
     "http://coderepos.org/share/export/38971/lang/elisp/init-loader/init-loader.el"
     ))
  (install-elisp-list-by-batch
   '("auto-complete"
     "anything")))
