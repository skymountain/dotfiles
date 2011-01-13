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