; utility
(defun foldl (f acc xs)
  (dolist (x xs acc)
    (setq acc (funcall f acc x))))

(defun foldr (f xs acc)
  (if (null xs) acc
    (funcall f (car xs) (foldr f (cdr xs) acc))))

(defun filter (my-filter-function xs)
  (foldr (lambda (x acc) (if (funcall my-filter-function x) (cons x acc) acc)) xs nil))

(defun string-match-last (r s &optional offset)
  (let ((idx (string-match r s offset)))
    (and idx
         (or (string-match-last r s (1+ idx)) idx))))

; custom
(defun custom-set-list (symbol seq)
  (let ((seq (if (listp seq) seq (cons seq nil)))
        (preseq (if (boundp symbol)
                    (symbol-value symbol)
                    ())))
    (custom-set-variables (list symbol '(append preseq seq) t))))

; function group
(defun add-function-to-group (symbol func)
  (let* ((tmp-list (get symbol 'function-group-list)))
    (put symbol 'function-group-list (add-to-list 'tmp-list func))))

(defun call-function-in-group (symbol arg &rest white-symbols)
  (let ((func-symbol-list (get symbol 'function-group-list)))
    (when white-symbols
      (setq func-symbol-list (filter (lambda (sym) (member sym white-symbols)) func-symbol-list)))
    (dolist (func func-symbol-list)
      (funcall func arg))))
