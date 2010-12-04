(setq skk-kakutei-key (kbd "C-b"))

; 変換時に改行でも確定
(setq skk-egg-like-newline t)

; メッセージは日本語で
(setq skk-japanese-message-and-error t)

; 「を入力したら」も自動で挿入
(setq skk-auto-insert-paren t)

; 漢字登録のミスをチェックする
(setq skk-check-okurigane-on-touroku t)

; 句読点を使う
(setq skk-kuten-touten-alist
      '(
        (jp . ("。" . "、"))
        (en . ("．" . "，"))
        ))

; jpにすると「。、」を使う
(setq-default skk-kutouten-type 'en)

; @で挿入する日付表示を半角に
(setq skk-number-style nil)

; 変換候補をツールチップに表示
(setq skk-show-tooltip t)

; 変換候補をインラインに表示
(setq skk-show-inline t)

; isearch畤にSKKをオフ
(setq skk-isearch-start-mode 'latin)

; specify sitcky key
(setq skk-sticky-key ";")

; specify dictionaries
(setq skk-search-prog-list
      '((skk-search-jisyo-file (expand-file-name "~/.dict/skk/SKK-JISYO.L") 10000)
        (skk-search-jisyo-file (expand-file-name "~/.dict/skk/SKK-JISYO.geo") 10000)
        (skk-search-jisyo-file (expand-file-name "~/.dict/skk/SKK-JISYO.jinmei") 10000)))

; 10分放置すると個人辞書が自動的に保存される設定
(defvar skk-auto-save-jisyo-interval 600)
(defun skk-auto-save-jisyo ()
  (skk-save-jisyo)
  )
(run-with-idle-timer skk-auto-save-jisyo-interval
                     skk-auto-save-jisyo-interval
                     'skk-auto-save-jisyo)

(define-keybinds global-map '(("C-x j" skk-mode)))