; yank indent mode
(global-yank-indent-mode 1)
(setq yank-indent-enabled-major-mode-list
      (append yank-indent-enabled-major-mode-list
              '(emacs-lisp-mode
                lisp-interaction-mode
                scheme-mode
                lisp-mode
                c-mode
                c++-mode
                objc-mode
                latex-mode
                plain-tex-mode
                yatex-mode
                ocaml-mode
                )))

; undo tree
(require 'undo-tree)
(global-undo-tree-mode 1)
(define-keybinds global-map
  '(("C-_" undo-tree-undo)
    ("C-\\" undo-tree-redo)))

; point-undo
(require 'point-undo)
(define-keybinds global-map
  '(("C-c C-_" point-undo)
    ("C-c C-\\" point-redo)
    ))

; auto insert
(require 'autoinsert)
(auto-insert-mode 1)
(custom-set-variables
  '(auto-insert-directory (expand-file-name "~/.emacs.d/conf/template"))
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

(define-keybinds global-map
  '(("M-g" moccur-grep-find)
    ))

(defun moccur-modify-keybinds (map)
  (define-keybinds map
    '(("C-v" nil)
      ("M-v" nil)
      )))

(moccur-modify-keybinds moccur-mode-map)
(defadvice moccur-set-key (after moccur-set-key-after-advice activate)
  (moccur-modify-keybinds ad-return-value))

(defun add-moccur-exclusion-mask (masks)
  (custom-set-list 'dmoccur-exclusion-mask masks))

(add-function-to-group 'ignore-files-by-regexp-list 'add-moccur-exclusion-mask)

; gtags
(require 'gtags)
(custom-set-variables
 '(gtags-path-style 'relative)
 )

;; ; migemo
;; (require 'migemo)
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs"))
;; (setq migemo-dictionary "~/tools/cmigemo/share/migemo/utf-8/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)
;; (setq migemo-coding-system 'utf-8-unix)
;; (load-library "migemo")
;; (migemo-init)
