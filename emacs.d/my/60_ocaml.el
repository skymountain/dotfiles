; ocaml-mode(tuareg)
(require 'tuareg)
(require 'ocamlspot)

(when (member '("\\.ml\\'" . lisp-mode) auto-mode-alist)
  (setq auto-mode-alist (delete '("\\.ml\\'" . lisp-mode) auto-mode-alist)))
(add-to-list 'auto-mode-alist '("\\.ml\\w?" . tuareg-mode))

(setq ocamlspot-command (expand-file-name "~/.opam/4.00.1+annot/bin/ocamlspot"))

(define-keybinds global-map
  '(("C-c C-o" tuareg-run-caml)
    ))
(custom-set-variables
  '(tuareg-in-indent 0)
  '(tuareg-with-indent 0)
  '(tuareg-function-indent 0)
  '(tuareg-parse-indent 0)
  )

(add-to-list 'ac-modes 'tuareg-mode)
(add-hook 'tuareg-mode-hook
          (lambda ()
            (define-keybinds tuareg-mode-map
              '(("C-c C-s" shell-pop)
                ("C-c e"   next-error)

                ; ocamlspot
                ("C-c ;"   ocamlspot-query)
                ("C-c :"   ocamlspot-query-interface)
                ("C-c C-t" ocamlspot-type)
                ("C-c C-y" ocamlspot-type-and-copy)
                ("C-c C-u" ocamlspot-use)
                ("C-c t"   caml-types-show-type)
                ))
            (if (boundp 'ocamlspot-spot-face)
                (set-face-background 'ocamlspot-spot-face "#660000"))
            (if (boundp 'ocamlspot-tree-face)
                (set-face-background 'ocamlspot-tree-face "#006600"))
            ))

(add-hook 'tuareg-interactive-mode-hook
          (lambda ()
            (define-keybinds tuareg-interactive-mode-map
              '(("C-j"     backward-char)
                ("M-j"     backward-word)
                ("C-c C-s" shell-pop)
                ))
            ))

; flymake
(defun flymake-ocaml-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-ocaml-cmdline))
(defun flymake-get-ocaml-cmdline (source base-dir)
  (list (expand-file-name "~/.emacs.d/script/flymake/ocaml_flycheck.pl")
        (list source base-dir)))

(push '(".+\\.ml[yilp]?$" flymake-ocaml-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.ml[yilp]?\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (if (not (null buffer-file-name)) (flymake-mode))
            (define-keybinds tuareg-mode-map
              '(("C-c d" flymake-display-err-minibuf)))
            ))

(call-function-in-group 'ignore-files-by-regexp-list
                        '("\\.spit$"
                          "\\.spot$"
                          "\\.annot$"
                          "\\.cmi$"
                          "\\.cmo$"
                          "\\.cmx$"
                          ))
