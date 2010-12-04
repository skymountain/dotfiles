; uniquify
(require 'uniquify)
(custom-set-variables
  '(uniquify-buffer-name-style (quote post-forward-angle-brackets))
  '(uniquify-ignore-buffers-re "*[^*]+*")
  )

; ido
(require 'ido)
(add-hook 'ido-setup-hook 
	  (lambda ()
	    "Add my keybindings for ido."
	    (define-keybinds ido-completion-map
	      '(("C-f" ido-next-match)
		("C-j" ido-prev-match)
		("SPC"   ido-exit-minibuffer)
		("C-m" ido-select-text)
		("C-h" delete-backward-char)
		("M-h" backward-kill-word)
		))
	    ))

(ido-mode 'files)
(custom-set-variables
  '(ido-enable-flex-matching t)
  )