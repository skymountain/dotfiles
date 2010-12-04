; c common style
(add-hook 'c-mode-common-hook
          (lambda ()
	    (require 'cpp-complt)
	    (cpp-complt-init)

	    (c-set-style "gnu")
	    (setq comment-start-skip "*")
	    (c-toggle-hungry-state 1)
	    
	    (let ((maps '(c-mode-map c++-mode-map)))
	      (dolist (map maps)
		(define-keybinds map
		  '(("#"         cpp-complt-instruction-completing)
		    ("C-c #"     cpp-complt-ifdef-region)
		    ("C-c #"     cpp-complt-ifdef-region)
		    ("C-c C-e"   end-of-buffer)
		    ("C-c C-b"   beginning-of-buffer)
		    ("C-c m"     c-macro-expand)
		    ("C-t"       ff-find-other-file)
		    ("C-c C-M-c" uncomment-region)))))
	    ))

; c++-mode
(add-hook 'c++-mode-hook
          (lambda ()
            (setq comment-start "// ")
            (setq comment-end   "")
            ))

; include path
(if (boundp 'header-dirs)
    (setq cpp-complt-standard-header-path header-dirs))

; allocate *.h to c++ mode
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
