
;; (let ((alist nil)
;;       (replacer-factory (lambda (keywords)
;;                           (message "HERE!!!")
;;                           (save-excursion
;;                             (goto-char (point-min))
;;                             (mapcar
;;                              (lambda (p)
;;                                (let ((key (car p))
;;                                      (value (cdr p)))
;;                                  (replace-string key (funcall value))))
;;                              keywords)))))
;;   ; ************
;;   ; perl
;;   ; ************
;;   (progn 
;;     (let* ((my-build-perl-package
;;             (lambda (my-build-perl-package dir)
;;               (unless (null dir)
;;                 (let* ((dir (directory-file-name dir))
;;                        (basename (file-name-nondirectory dir)))
;;                   (cond ((string= basename "lib") "")
;;                         ((string= basename "") nil)
;;                         (t (let ((package (my-build-perl-package (file-name-directory dir))))
;;                              (unless (null package)
;;                                (concat package
;;                                        (if (string= package "") "" "::")
;;                                        basename)))))))))
;;           (my-build-perl-package (apply-partially my-build-perl-package my-build-perl-package))
;;           (keywords (list
;;                      (cons "%PACKAGE"
;;                            (apply-partially
;;                             (lambda (my-build-perl-package)
;;                               (let* ((package (funcall my-build-perl-package default-directory))
;;                                      (class (file-name-sans-extension
;;                                              (file-name-nondirectory buffer-file-name)))
;;                                      (module (if (null package)
;;                                                  class
;;                                                (concat package "::" class))))
;;                                 (concat "package " module ";")))
;;                             my-build-perl-package
;;                             ))
;;                      ))
;;           (r (apply-partially replacer-factory keywords)))
;;       (defun  r () ((apply-partially replacer-factory keywords)))
;;       (add-to-list 'alist (cons "\\.pm$" (vector "template.pm" (quote r))))))
;;   (print ">>>")
;;   (print alist)
;;   (print ">>>")
;;     ; ************
;;   ; register auto-inserts
;;   ; ************
;;   (custom-set-variables
;;     `(auto-insert-alist ,alist)
;;     ))
