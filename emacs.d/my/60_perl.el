; map perl-mode to cperl-mode, which is amore advanced mode for perl.
(let* ((re-list '("\\.t$"))
       (re (join "\\|" re-list))
       (default-re "\\.\\([pP]\\([Llm]\\|erl\\|od\\)\\|al\\)\\'")
       (re-generator (lambda (pre-re) (concat re  "\\|" pre-re)))
       (list-sym-list '(auto-mode-alist interpreter-mode-alist))
       (mapper (lambda (alist-sym)
                 (let ((defined nil))
                   (unless (dolist (p (eval alist-sym) defined)
                             (when (eq (cdr p) 'perl-mode)
                               (setq defined t)
                               (setcdr p 'cperl-mode)
                               (setcar p (funcall re-generator (car p)))))
                     (add-to-list alist-sym (cons (re-generator default-re) 'cperl-mode)))))))
  (mapc mapper list-sym-list))

; turn off displaying spaces as underlines
(custom-set-variables
 '(cperl-invalid-face nil)
 )

(add-hook 'cperl-mode-hook
          (lambda ()
            (defvar plcmp-use-keymap nil)
            (require 'perl-completion)
            (global-keybinds-define-keybinds cperl-mode-map)
            (perl-completion-mode t)
            (add-to-list 'ac-sources 'ac-source-perl-completion)
            (define-keybinds cperl-mode-map
              '(("C-c C-h" plcmp-cmd-show-doc)
                ("C-c h"   plcmp-cmd-show-doc-at-point)
                ("C-o"     plcmp-cmd-smart-complete)
                ))
            ))

; env variable for perl
(defun perl-get-perllib-module-path-list (modules-dir)
  (when (file-exists-p modules-dir)
    (flatten
     (mapcar (lambda (module-name)
               (let* ((module-dir  (concat modules-dir "/" module-name))
                      (lib-dir     (concat module-dir "/lib"))
                      (testlib-dir (concat module-dir "/t/lib")))
                 (filter 'file-exists-p (list lib-dir testlib-dir))))
             (filter (lambda (basename) (not (string-match "^\\.+$" basename)))
                     (directory-files modules-dir))))))

(defun perl-get-perllib-path-list (path)
  (let ((p (split-to-pair "/" path 'string-match-last)))
    (when (and p (not (string= (car p) "")))
      (let* ((dir         (car p))
             (lib-dir     (concat dir "/lib"))
             (modules-dir (concat dir "/modules"))
             (testlib-dir (concat dir "/t/lib"))
             (libs        (filter 'file-exists-p (list lib-dir testlib-dir)))
             (libs        (append libs
                                  (perl-get-perllib-module-path-list modules-dir))))
        (append libs (perl-get-perllib-path-list dir))))))

(defun env-init-perl (path)
  (let ((libs (perl-get-perllib-path-list path)))
    (when libs
      (env-append "PERL5LIB" libs))))

; flymake for perl
(defvar flymake-perl-err-line-patterns '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))
(defconst flymake-allowed-perl-file-name-masks '(("\\.pl$" flymake-perl-init)
                                                 ("\\.pm$" flymake-perl-init)
                                                 ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check
    (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (env-init-perl buffer-file-name)
  (flymake-mode t))

(add-hook 'cperl-mode-hook '(lambda ()
                              (flymake-perl-load)
                              ))

; auto insert
(auto-insert-register
 "\\.pm$" [ "template.pm" auto-insert-dynamically ]
 '(("%PACKAGE" .
   (lambda ()
     (let* ((path (buffer-file-name))
            (dirname (file-name-directory path))
            (basename (file-name-sans-extension (file-name-nondirectory path)))
            (idx (string-match-last "/lib/" dirname))
            (module (if idx
                        (let ((dummy-module (substring dirname (+ idx 5))))
                          (replace-regexp-in-string  "/" "::" dummy-module))
                      "")))
       (concat "package " module basename ";"))))
  ))
(auto-insert-register "\\.t$" "template.t")
 
; auto insert brackets
(add-hook 'cperl-mode-hook
          (lambda ()
            (define-keybinds cperl-mode-map
              '(("{"      insert-braces)
                ("("      insert-parens)
                ("\""     insert-double-quotation)
                ("["      insert-brackets)
                ("C-c }"  insert-braces-region)
                ("C-c )"  insert-parens-region)
                ("C-c ]"  insert-brackets-region)
                ("C-c \"" insert-double-quotation-region)
                ))
            ))
