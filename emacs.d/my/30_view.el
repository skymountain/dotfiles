; the statements in (),[],{} and etc are bold style
(show-paren-mode t)  ; colored parens
(require 'mic-paren) ; bold and colored text
(paren-activate)
(custom-set-variables
  '(paren-sexp-mode t)
  )

; pretty-lambdada
; show the word `lambda' as the Greek letter
(require 'pretty-lambdada)
(pretty-lambda-for-modes)

; describe face
(defun describe-face-at-point ()
  "Show a face at the point of the current cursor"
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

; view-mode
(add-hook 'view-mode-hook
          (lambda ()
            (define-keybinds view-mode-map
              '(("j" (lambda () (interactive) (scroll-up 1)))
                ("k" (lambda () (interactive) (scroll-down 1)))
                ("h" backward-char)
                ("l" forward-char)
                ("b" scroll-down)
                ("F" nil)
                ("C-j" (lambda () (interactive) (scroll-up 10)))
                ("C-k" (lambda () (interactive) (scroll-down 10)))
              ))
            ))

(defun view-mode-in-major-mode (mode-hook)
  (add-hook mode-hook (lambda ()
                        (view-mode 1)
                        )))
