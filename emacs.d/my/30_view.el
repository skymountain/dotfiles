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
