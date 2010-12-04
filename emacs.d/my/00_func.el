(defun foldl (f acc xs)
  (dolist (x xs acc)
    (setq acc (funcall f acc x))))

(defun foldr (f xs acc)
  (if xs
      (f (car xs) (foldr (cdr xs) acc))
      acc))

(defun string-match-last (r s &optional offset)
  (let ((idx (string-match r s offset)))
    (and idx
         (or (string-match-last r s (1+ idx)) idx))))