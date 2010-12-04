;; *****************
;; scheme-mode
;; *****************
;; (setq scheme-program-name scheme-path)
;; (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;; (defun scheme-other-window()
;;   "Run scheme on other window"
;;   (interactive)
;;   (switch-to-buffer-other-window
;;    (get-buffer-create "*scheme*"))
;;   (run-scheme gosh-program-name))
;; (autoload 'scheme-smart-complete "scheme-complete" nil t)
;; (eval-after-load 'scheme
;;   '(progn (define-key scheme-mode-map "\C-c\t" 'scheme-smart-complete)))
;; (define-key global-map "\C-cs" 'run-scheme)

