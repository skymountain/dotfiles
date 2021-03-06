(set-language-environment "Japanese")

(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(menu-bar-mode 0)
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))
(if (fboundp 'toggle-scroll-bar)
    (toggle-scroll-bar nil))
(unless (boundp 'warning-suppress-types)
  (setq warning-suppress-types nil))
(unless (boundp 'image-load-path)
  (setq image-load-path ()))
(when (fboundp 'resize-minibuffer-mode)
  (resize-minibuffer-mode)
  (setq resize-minibuffer-window-exactly nil))

(global-font-lock-mode 1)
(setq-default ring-bell-function 'ignore)
(setq-default frame-title-format "%b")
(line-number-mode 1)
(column-number-mode 1)

(put 'upcase-region 'disabled nil)
(setq-default tab-width 2)
(setq-default column-width 80)
(custom-set-variables
  '(compilation-window-height 10)
  '(tab-width 2)
  '(inhibit-startup-message t)
  '(truncate-partial-width-windows nil)
  '(enable-recursive-minibuffers t)
  '(echo-keystrokes 0.1)
  '(use-dialog-box nil)
  '(history-length 1000)
  '(transient-mark-mode t)
  '(indent-tabs-mode nil)
  `(fill-column ,column-width)
)

(defvar vc-entries
  '(".git"
    ".svn"
    ))

(defalias 'message-box 'message)
(defalias 'yes-or-no-p 'y-or-n-p)
