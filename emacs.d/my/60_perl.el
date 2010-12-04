; map perl-mode to cperl-mode, which is amore advanced mode for perl.
(mapc
 (lambda (p)
   (if (eq (cdr p) 'perl-mode)
       (setcdr p 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))


; turn off displaying spaces as underlines
(custom-set-variables
 '(cperl-invalid-face nil)
 )

(add-hook 'cperl-mode-hook
          (lambda ()
            (defvar plcmp-use-keymap nil)
            (require 'perl-completion)
            (define-global-keybinds cperl-mode-map)
            (perl-completion-mode t)
            (add-to-list 'ac-sources 'ac-source-perl-completion)
            (define-keybinds cperl-mode-map
              '(("C-c C-h" plcmp-cmd-show-doc)
                ("C-c h"   plcmp-cmd-show-doc-at-point)
                ("C-o"     plcmp-cmd-smart-complete)
                ))
            ))

; flymake for perl
; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
(require 'set-perl5lib)
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
  (set-perl5lib)
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