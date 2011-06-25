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

(defun join (separator sequence)
  (mapconcat 'identity sequence separator))

(defun uniq (sequence)
  (let ((ret nil))
    (dolist (x sequence (reverse ret))
      (unless (member x ret)
        (add-to-list 'ret x)))))

(defun flatten (sequences)
  (let ((ret nil))
    (dolist (seq sequences (reverse ret))
      (dolist (x seq)
        (setq ret (cons x ret))))))

(defun split-to-pair (r s &optional match)
  (let* ((f (or match 'string-match))
         (idx (funcall f r s)))
    (when idx
      (let ((fst (if (= idx 0) "" (substring s 0 idx)))
            (snd (substring s (1+ idx) (length s))))
        (cons fst snd)))))

(defun split (r s)
  (let ((iter (lambda (s)
                (let ((p (split-to-pair r s)))
                  (cond (p (cons (car p)
                                 (funcall iter (cdr p))))
                        (t (list s)))))))
    (funcall iter s)))

(defun exists (pred xs)
  (when xs
    (if (funcall pred (car xs)) t
        (exists pred (cdr xs)))))

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

; assoc
(defun assoc-modify (assoc-list modifier-list)
  (let ((assoc-add    (lambda (key value)
                        (add-to-list 'assoc-list (cons key value))))
        (assoc-delete (lambda (key)
                        (setq assoc-list (assq-delete-all key assoc-list))))
        (assoc-modify (lambda (target-key new-value)
                        (setq assoc-list
                              (mapcar (lambda (key-value)
                                        (let ((key   (car key-value))
                                              (value (cdr key-value)))
                                          (cons key
                                                (if (eq key target-key)
                                                    new-value value))))
                                      assoc-list)))))
    (dolist (modifier-info
             modifier-list
             assoc-list)
      (let ((op    (car  modifier-info))
            (key   (cadr modifier-info))
            (value (cddr modifier-info)))
        (cond ((eq op 'delete) (funcall assoc-delete key))
              ((eq op 'add)    (funcall assoc-add    key value))
              ((eq op 'modify) (funcall assoc-modify key value)))
        ))))

;;
;; sample code
;;
;; add(assoc-modify-packed
;;     '((a 1) (b 2) (c 3) (d . 4))
;;     '((delete a c)))

;; (assoc-modify-packed
;;  '((a 1) (b 2) (c 3) (d . 4))
;;  '((delete (a) (c))))

;; (assoc-modify-packed
;;  '((a 1) (b 2) (c 3) (d . 4))
;;  '((add (a 10) (e . 5))))

;; (assoc-modify-packed
;;  '((a 1) (b 2) (c 3) (d . 4))
;;  '((modify (a 10) (e . 5))))
;;
(defun assoc-modify-packed (assoc-list packed-modifier-list)
  (let ((modifier-list
         (flatten (mapcar
                   (lambda (packed-modifier-info)
                     (let ((op (car packed-modifier-info))
                           (key-maybe-value-list (cdr packed-modifier-info)))
                       (mapcar
                        (lambda (key-maybe-value)
                          (cons op
                                (if (listp key-maybe-value)
                                    key-maybe-value
                                    (list key-maybe-value))))
                        key-maybe-value-list)))
                   packed-modifier-list))))
    (assoc-modify assoc-list modifier-list)))

; file/directory
(defun find-ceiling-directory (path pred)
  (let ((p (split-to-pair "/" path 'string-match-last)))
    (when p
      (let ((dir (car p)))
        (if (funcall pred dir) dir
            (find-ceiling-directory dir pred))))))

(defun find-ceiling-directory-entries-or (path entry-names)
  (find-ceiling-directory path
                          (lambda (dir)
                            (exists
                             (lambda (entry-name)
                               (let ((entry (concat dir "/" entry-name)))
                                 (file-exists-p entry)))
                             entry-names))))

; buffer
(defun buffer-clear ()
  (interactive)
  (delete-region (point-min) (point-max)))

(defun overwrite-file-contents (file-path)
  (buffer-clear)
  (insert-file-contents file-path))
