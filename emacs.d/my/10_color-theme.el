; This theme is a mixture of charcoal-black and dark-laptop
; and is based on charcoal-black.
(defvar my-color-theme
  '(my-color-theme
    ((background-color . "Grey15")
     (background-mode . dark)
     (border-color . "Grey")
     (cursor-color . "Grey")
     (foreground-color . "Grey")
     (mouse-color . "Grey"))
    ((gnus-mouse-face . highlight)
     (list-matching-lines-face . bold)
     (view-highlight-face . highlight))
    (default ((t (nil))))
    (bold ((t (:bold t))))
    (bold-italic ((t (:italic t :bold t))))

    ;; add
    (cursor ((t (:background "Grey"))))

    (custom-button-face ((t (nil))))
    (custom-changed-face ((t (:background "blue" :foreground "white"))))
    (custom-documentation-face ((t (nil))))
    (custom-face-tag-face ((t (:underline t))))
    (custom-group-tag-face ((t (:underline t :foreground "light blue"))))
    (custom-group-tag-face-1 ((t (:underline t :foreground "pink"))))
    (custom-invalid-face ((t (:background "red" :foreground "yellow"))))
    (custom-modified-face ((t (:background "blue" :foreground "white"))))
    (custom-rogue-face ((t (:background "black" :foreground "pink"))))
    (custom-saved-face ((t (:underline t))))
    (custom-set-face ((t (:background "white" :foreground "blue"))))
    (custom-state-face ((t (:foreground "lime green"))))
    (custom-variable-button-face ((t (:underline t :bold t))))
    (custom-variable-tag-face ((t (:underline t :foreground "light blue"))))
    (fl-comment-face ((t (:foreground "pink"))))
    (fl-doc-string-face ((t (:foreground "purple"))))
    (fl-function-name-face ((t (:foreground "red"))))
    (fl-keyword-face ((t (:foreground "cyan"))))
    (fl-string-face ((t (:foreground "green"))))
    (fl-type-face ((t (:foreground "yellow"))))
    (font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))

    (font-lock-comment-face ((t (:foreground "DarkSea"))))
    (font-lock-constant-face ((t (:foreground "Aquamarine"))))
    (font-lock-doc-string-face ((t (:foreground "LightSalmon"))))
    (font-lock-function-name-face ((t (:foreground "medium slate blue"))))
    (font-lock-keyword-face ((t (:foreground "SteelBlue"))))
    (font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
    (font-lock-reference-face ((t (:foreground "LightSteelBlue"))))
    (font-lock-string-face ((t (:foreground "goldenrod"))))
    (font-lock-type-face ((t (:foreground "LightSkyBlue2"))))
    (font-lock-variable-name-face ((t (:foreground "wheat"))))
    (font-lock-warning-face ((t (:bold t :foreground "Pink"))))

    ;; add
    (fringe ((t (:background "Grey15"))))

    (gnus-cite-attribution-face ((t (:italic t))))
    (gnus-cite-face-1 ((t (:bold t :foreground "deep sky blue"))))
    (gnus-cite-face-10 ((t (:foreground "medium purple"))))
    (gnus-cite-face-11 ((t (:foreground "turquoise"))))
    (gnus-cite-face-2 ((t (:bold t :foreground "cyan"))))
    (gnus-cite-face-3 ((t (:bold t :foreground "gold"))))
    (gnus-cite-face-4 ((t (:foreground "light pink"))))
    (gnus-cite-face-5 ((t (:foreground "pale green"))))
    (gnus-cite-face-6 ((t (:bold t :foreground "chocolate"))))
    (gnus-cite-face-7 ((t (:foreground "orange"))))
    (gnus-cite-face-8 ((t (:foreground "magenta"))))
    (gnus-cite-face-9 ((t (:foreground "violet"))))
    (gnus-emphasis-bold ((t (:bold t))))
    (gnus-emphasis-bold-italic ((t (:italic t :bold t))))
    (gnus-emphasis-highlight-words ((t (:background "black" :foreground "yellow"))))
    (gnus-emphasis-italic ((t (:italic t))))
    (gnus-emphasis-underline ((t (:underline t))))
    (gnus-emphasis-underline-bold ((t (:underline t :bold t))))
    (gnus-emphasis-underline-bold-italic ((t (:underline t :italic t :bold t))))
    (gnus-emphasis-underline-italic ((t (:underline t :italic t))))
    (gnus-group-mail-1-empty-face ((t (:foreground "aquamarine1"))))
    (gnus-group-mail-1-face ((t (:bold t :foreground "aquamarine1"))))
    (gnus-group-mail-2-empty-face ((t (:foreground "aquamarine2"))))
    (gnus-group-mail-2-face ((t (:bold t :foreground "aquamarine2"))))
    (gnus-group-mail-3-empty-face ((t (:foreground "aquamarine3"))))
    (gnus-group-mail-3-face ((t (:bold t :foreground "aquamarine3"))))
    (gnus-group-mail-low-empty-face ((t (:foreground "aquamarine4"))))
    (gnus-group-mail-low-face ((t (:bold t :foreground "aquamarine4"))))
    (gnus-group-news-1-empty-face ((t (:foreground "PaleTurquoise"))))
    (gnus-group-news-1-face ((t (:bold t :foreground "PaleTurquoise"))))
    (gnus-group-news-2-empty-face ((t (:foreground "turquoise"))))
    (gnus-group-news-2-face ((t (:bold t :foreground "turquoise"))))
    (gnus-group-news-3-empty-face ((t (nil))))
    (gnus-group-news-3-face ((t (:bold t))))
    (gnus-group-news-4-empty-face ((t (nil))))
    (gnus-group-news-4-face ((t (:bold t))))
    (gnus-group-news-5-empty-face ((t (nil))))
    (gnus-group-news-5-face ((t (:bold t))))
    (gnus-group-news-6-empty-face ((t (nil))))
    (gnus-group-news-6-face ((t (:bold t))))
    (gnus-group-news-low-empty-face ((t (:foreground "DarkTurquoise"))))
    (gnus-group-news-low-face ((t (:bold t :foreground "DarkTurquoise"))))
    (gnus-header-content-face ((t (:italic t :foreground "forest green"))))
    (gnus-header-from-face ((t (:bold t :foreground "spring green"))))
    (gnus-header-name-face ((t (:foreground "deep sky blue"))))
    (gnus-header-newsgroups-face ((t (:italic t :bold t :foreground "purple"))))
    (gnus-header-subject-face ((t (:bold t :foreground "orange"))))
    (gnus-signature-face ((t (:bold t :foreground "khaki"))))
    (gnus-splash-face ((t (:foreground "Brown"))))
    (gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
    (gnus-summary-high-ancient-face ((t (:bold t :foreground "SkyBlue"))))
    (gnus-summary-high-read-face ((t (:bold t :foreground "PaleGreen"))))
    (gnus-summary-high-ticked-face ((t (:bold t :foreground "pink"))))
    (gnus-summary-high-unread-face ((t (:bold t))))
    (gnus-summary-low-ancient-face ((t (:italic t :foreground "SkyBlue"))))
    (gnus-summary-low-read-face ((t (:italic t :foreground "PaleGreen"))))
    (gnus-summary-low-ticked-face ((t (:italic t :foreground "pink"))))
    (gnus-summary-low-unread-face ((t (:italic t))))
    (gnus-summary-normal-ancient-face ((t (:foreground "SkyBlue"))))
    (gnus-summary-normal-read-face ((t (:foreground "PaleGreen"))))
    (gnus-summary-normal-ticked-face ((t (:foreground "pink"))))
    (gnus-summary-normal-unread-face ((t (nil))))
    (gnus-summary-selected-face ((t (:underline t))))
    (highlight ((t (:background "SteelBlue4"))))
    (italic ((t (:italic t))))
    (message-cited-text-face ((t (:bold t :foreground "red"))))
    (message-header-cc-face ((t (:bold t :foreground "green4"))))
    (message-header-name-face ((t (:bold t :foreground "orange"))))
    (message-header-newsgroups-face ((t (:bold t :foreground "violet"))))
    (message-header-other-face ((t (:bold t :foreground "chocolate"))))
    (message-header-subject-face ((t (:bold t :foreground "yellow"))))
    (message-header-to-face ((t (:bold t :foreground "cyan"))))
    (message-header-xheader-face ((t (:bold t :foreground "light blue"))))
    (message-mml-face ((t (:bold t :background "Green3"))))
    (message-separator-face ((t (:foreground "blue3"))))
    (modeline ((t (:background "white" :foreground "black"))))
    (modeline-buffer-id ((t (:background "white" :foreground "black"))))
    (modeline-mousable ((t (:background "white" :foreground "black"))))
    (modeline-mousable-minor-mode ((t (:background "white" :foreground "black"))))

    ;; add
    (mouse ((t (:background "Grey"))))

    ;; change
    ;; (region ((t (:background "blue"))))
    ;; (primary-selection ((t (:background "blue"))))
    ;; (isearch ((t (:background "pink"))))
    ;; (zmacs-region ((t (:background "blue"))))
    (region ((t (:background "RoyalBlue4"))))
    (primary-selection ((t (:background "RoyalBlue4"))))
    (isearch ((t (:background "RoyalBlue4"))))
    (zmacs-region ((t (:background "RoyalBlue4"))))

    (secondary-selection ((t (:background "darkslateblue"))))
    (underline ((t (:underline t))))
    (widget-button-face ((t (:bold t))))
    (widget-button-pressed-face ((t (:foreground "red"))))
    (widget-documentation-face ((t (:foreground "lime green"))))
    (widget-field-face ((t (:background "dim gray"))))
    (widget-inactive-face ((t (:foreground "light gray"))))
    (widget-single-line-field-face ((t (:background "dim gray"))))

    ;; anything
    (anything-file-name ((t (:foreground "white"))))
    (anything-dir-priv ((t (:background "Gray15" :foreground "SteelBlue1"))))
    (paren-face-match ((t (:bold t :background "Gray20"))))
    (flymake-errline ((t (:background "firebrick"))))
    (flymake-warnline ((t (:background "gold"))))

    ;; tuareg
    (tuareg-font-lock-governing-face ((t (:foreground "SteelBlue"))))
    ))

(defun my-color-theme ()
  "Color theme by Taro Sekiyama"
  (interactive)
  my-color-theme)
