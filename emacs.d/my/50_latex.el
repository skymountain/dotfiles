; YaTeX
; automatically change major-mode to yatex-mode if the extension is .tex
(setq auto-mode-alist (cons '("\\.tex$" . yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;;   1=Shift JIS
;;   2=JIS
;;   3=EUC
;;   4=UTF-8
(setq YaTeX-kanji-code 3)
(setq tex-command (expand-file-name "~/.emacs.d/script/tex/texpdf.sh"))
(setq dvi2-command "dviout");
(setq YaTeX-nervous nil)

(setq YaTeX-help-file
      (expand-file-name "YATEHELP.jp" data-directory))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (require 'font-latex)
             (font-latex-setup)

             (setq fill-column 80)
             ))

;; ;; *****************
;; ;; AUCTex
;; ;; *****************
;; (load "auctex.el")
;; (require 'preview-latex)
;; (require 'tex-jp)
;; ;; (custom-set-variables
;; ;;  '(Tex-auto-global (expand-file-name "~/.emacs.d/conf/auctex/"))
;; ;;  '(TeX-auto-private ((expand-file-name "~/.emacs.d/conf/auctex/")))
;; ;;  '(TeX-style-global (expand-file-name "~/.emacs.d/elisp/auctex/auctex/style/"))
;; ;;  '(TeX-style-private ((expand-file-name "~/.emacs.d/elisp/auctex/auctex/style/")))
;; ;;  '(TeX-macro-default (expand-file-name "~/texmf/tex/"))
;; ;;  '(TeX-macro-private ((expand-file-name "~/texmf/tex/")))
;; ;;  '(TeX-auto-default (expnad-file-name "~/.emacs.d/conf/auctex/auto/"))
;; ;;  '(TeX-auto-private ((expnad-file-name "~/.emacs.d/conf/auctex/auto/")))
;; ;;  '(TeX-kpathsea-path-delimiter t)
;; ;;  '(LaTeX-command "platex")
;; ;;  '(TeX-japanese-process-input-coding-system 'euc-jp-unix)
;; ;;  '(TeX-japanese-process-output-coding-system 'euc-jp-unix)
;; ;;  '(japanese-TeX-command-default "platex"))

;; ;; *****************
;; ;; cmigemo
;; ;; *****************
;; ;; base settings
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs"))
;; ;; a path to migemo-dict
;; (setq migemo-dictionary (expand-file-name "~/.emacs.d/conf/cmigemo/dict/migemo-dict"))
;; (setq migemo-coding-system 'euc-jp-unix)
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)

;; ;; use cashe
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)

;; (require 'migemo)
;; ;;; initialize when exec
;; (migemo-init)
