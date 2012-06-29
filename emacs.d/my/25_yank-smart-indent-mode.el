; smart indent for paste
; http://www.emacswiki.org/emacs/AutoIndentation#SmartPaste

(defvar yank-indent-enabled-major-mode-list
  "Major mode list enabling yank-indent-mode"
  nil)

(defadvice yank (after indent-region disable)
  (if (member major-mode yank-indent-enabled-major-mode-list)
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defun turn-on-yank-indent-mode ()
  "Enable yank-indent-mode."
  (yank-indent-mode 1))

(easy-mmode-define-minor-mode
 yank-indent-mode
 "yank smart indent mode"
 nil
 " Yank-Indent"
 nil
 (funcall
  (if yank-indent-mode 'ad-enable-advice 'ad-disable-advice)
  'yank 'after 'indent-region)
 (ad-activate 'yank)
 )

(define-globalized-minor-mode global-yank-indent-mode
  yank-indent-mode turn-on-yank-indent-mode)