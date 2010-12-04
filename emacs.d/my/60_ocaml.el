; ocaml-mode(tuareg)
(require 'tuareg)
(require 'ocamlspot)
(add-to-list 'auto-mode-alist '("\\.ml\\w?" . tuareg-mode))
(setq ocamlspot-command "/usr/local/ocaml/bin/ocamlspot")

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
	    (define-keybinds current-local-map
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

	    (set-face-background 'ocamlspot-spot-face "#660000")
	    (set-face-background 'ocamlspot-tree-face "#006600")
	    ))

(add-hook 'tuareg-interactive-mode-hook
          (lambda ()
	    (define-keybinds current-local-map
	      '(("C-j"     backward-char)
		("M-j"     backward-word)
		("C-c C-s" shell-pop)
		))
	    ))

; flymake for ocaml
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
	    ;; (local-set-key (kbd "C-c d") 'flymake-display-err-minibuf)
	    ))

