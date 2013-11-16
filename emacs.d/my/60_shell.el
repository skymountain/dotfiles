; sh-script
(setq sh-basic-offset 2)
(add-to-list 'auto-mode-alist
             '("^\\.?\\(bashrc\\)\\|\\(profile\\)\\|\\(zshrc\\)$" . shell-script-mode))

; shell
(require 'shell-pop)
(custom-set-variables
 '(shell-pop-shell-type
   (quote ("ansi-term" "*ansi-term*" (lambda () (ansi-term shell-pop-term-shell)))))
 `(shell-pop-term-shell ,(getenv "ZSH"))
)

;; (setq shell-pop-window-height 30)
(define-keybinds global-map
  '(("C-c C-s" shell-pop)
    ))

;; change to current directory
(defun windows-p ()
  (memq system-type '(ms-dos windows-nt)))
(defun root-dir-p (dir)
  (or
   (and (windows-p)
        (string-match-p "[A-Z]:\\\\\\|\\\\\\\\" dir))
   (string= "/" dir)))
(defun upward-dir (path)
  (let ((regexp (if (windows-p)
                    "^\\(.*[\\]\\)[^\\]+[\\]?$"
                  "^\\(.*/\\)[^/]+/?$")))
    (cond ((root-dir-p path) path)
          ((string-match regexp path)
           (match-string 1 path))
          ;; '/hoge//' which is one of examples for path
          (t nil))))
(defadvice shell-pop-up (around shell-popup-around activate)
  (let ((path
         (cond ((stringp buffer-file-name)
                (upward-dir (expand-file-name buffer-file-name)))
               ((not (string-match-p "^[:space:]*\\*.*\\*[:space]*$" (buffer-name)))
                (expand-file-name default-directory))
               (t nil))))
    ad-do-it
    (if (and path
             (not (string= path
                           (expand-file-name default-directory))))
        (term-send-raw-string (concat "cd " path "\n")))))

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
	  (lambda ()
	    (define-keybinds term-raw-map
	      '(("C-c C-s" shell-pop)
		))
	    ))
(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

