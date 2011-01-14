; smart indent for paste
; http://www.emacswiki.org/emacs/AutoIndentation#SmartPaste
(defadvice yank (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode
                scheme-mode
                lisp-mode
                c-mode
                c++-mode
                objc-mode
                latex-mode
                plain-tex-mode
                yatex-mode
                ocaml-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

; undo tree
(require 'undo-tree)
(global-undo-tree-mode 1)

; point-undo
(require 'point-undo)
(define-keybinds global-map
  '(("C-c C-/" point-undo)
    ("C-c C-?" point-redo)
    ))

; auto insert
(require 'autoinsert)
(auto-insert-mode 1)
(custom-set-variables
  '(auto-insert-directory (expand-file-name "~/.emacs.d/conf/auto-insert"))
  )

(defvar auto-insert-replacement-list ()
"Replacement is a list of the following format:

(STRING REPLACE)

Strings matched with STRING in template file are replaced by REPLACE, which is string or function which return string.")

(defun auto-insert-dynamically ()
  "skelton function for auto-insert"
  (let ((replacement (foldl (lambda (acc x) (cond (acc acc)
                                             ((string-match (car x) buffer-file-name) (cdr x))
                                             (t acc)))
                            nil auto-insert-replacement-list)))
    (save-excursion
      (goto-char (point-min))
      (mapcar
       (lambda (r)

         (let ((key (car r))
               (value (cdr r)))
           (replace-string key
                           (if (stringp value) value
                             (funcall value)))
           ))
       replacement))))

(defun auto-insert-register (regexp action &optional replacement)
  "Add ACTION to auto-insert-alist and REPLACEMENT to auto-insert-replacement-list for REGEXP."
  (add-to-list 'auto-insert-alist
               (cons regexp action))
  (when replacement (add-to-list 'auto-insert-replacement-list (cons regexp replacement))))
  
  
; auto insert brackets
(require 'brackets)

; diff
(load "diff-with-original")
(load "ediff-with-original")

; isearch-grep
(require 'isearch-grep)

; moccur
(require 'color-moccur)
(require 'moccur-edit)
(custom-set-variables
 '(moccur-split-word t)
 )

(defun add-moccur-exclusion-mask (masks)
  (custom-set-list 'dmoccur-exclusion-mask masks))
