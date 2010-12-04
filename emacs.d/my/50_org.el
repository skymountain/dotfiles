; iimage-mode
(require 'iimage)
(add-to-list 'iimage-mode-image-regex-alist
             (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                           "\\)\\]") 1))

; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(define-keybinds global-map
  '(("C-c l" org-store-link)
    ("C-c a" org-agenda)
    ("C-c b" org-iswitchb)
    ))

(custom-set-variables
  '(paragraph-start "^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")
)

(add-hook 'org-load-hook
          (lambda ()
	    (define-global-keybinds org-mode-map)
	    (define-keybinds org-mode-map
	      '(("M-n"     outline-next-visible-heading)
		("M-p"     outline-previous-visible-heading)
		("C-c C-w" sdic-describe-word)
		))
            (require 'filladapt)))

(add-hook 'org-mode-hook
	  (lambda ()
	    (turn-on-iimage-mode)
	    (define-keybinds org-mode-map
	      '(("C-c TAB" org-toggle-iimage-in-org)
		))
	    ))

(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (setq-face-underline-p 'org-link nil)
    (setq-face-underline-p 'org-link t))
  (iimage-mode))
