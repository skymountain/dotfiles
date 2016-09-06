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

(defun view-mode-globalize-on-find-file (mode)
  (let ((hook-fun (lambda () (view-mode t))))
    (if mode
        (add-hook    'find-file-hook hook-fun)
        (remove-hook 'find-file-hook hook-fun))))

;; (defvar view-mode-globalize-stack nil)
;; (make-variable-buffer-local 'view-mode-globalize-stack)

;; (defun view-mode-globalize-in-buffers (mode)
;;   (let ((global-state-modifier
;;          (if mode
;;              (lambda ()
;;                (setq view-mode-globalize-stack
;;                      (cons (if view-mode 1 0) view-mode-globalize-stack))
;;                (message "now view-mode: %s" view-mode)
;;                (view-mode 1))
;;              (lambda ()
;;                (let ((mode (pop view-mode-globalize-stack)))
;;                  (message "next view-mode: %s" mode)
;;                  (view-mode mode))))))
;;     (message "%s" mode)
;;     (save-excursion
;;       (dolist (buffer (buffer-list))
;;         (set-buffer buffer)
;;         (when buffer-file-name
;;           (message buffer-file-name)
;;           (funcall global-state-modifier))))))

(defun view-mode-globalize-function (arg)
  (let* ((symbol-name 'view-mode-globalize)
         (prop-name   'previous)
         (prev-mode (get symbol-name prop-name))
         (mode (cond ((null arg) (not prev-mode))
                     ((>= arg 1) t)
                     (t          nil))))
    (put symbol-name prop-name mode)
    (view-mode-globalize-on-find-file mode)
    ;; (view-mode-globalize-in-buffers mode)
    (view-mode (if mode 1 0))))

(defun view-mode-globalize (&optional arg)
  (interactive "P")
  (view-mode-globalize-function arg))


; whitespace
(require 'whitespace)
(setq whitespace-style
      '(
        face
        trailing
        tabs
        lines-tail
        ))
(setq whitespace-action nil)
(setq whitespace-line-column column-width)
(global-whitespace-mode 1)
(set-face-attribute 'whitespace-trailing nil
                    :background "gray20"
                    :foreground "violet"
                    :underline t)

;; dired
(require 'dired-subtree)
(require 'dired-details+)
(dired-details-install)

(add-hook 'dired-mode-hook
          (lambda ()
            (define-keybinds dired-mode-map
              '(("j" next-line)
                ("k" previous-line)
                ("i" dired-subtree-toggle)
                ("<tab>" dired-subtree-toggle)
                ("@" dired-details-toggle)
                ))
            ))

(setq dired-details-hide-link-targets nil)
(setq dired-details-initially-hide t)
(add-hook 'dired-subtree-after-insert-hook
          (lambda ()
            (dired-details-delete-overlays)
            (dired-details-activate)))
