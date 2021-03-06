(deftheme skymountain
  "Created 2012-11-21.")

(custom-theme-set-faces
 'skymountain
 '(cursor ((t (:background "red"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "color-39"))))
 '(highlight ((t (:background "SteelBlue4"))))
 '(region ((t (:background "RoyalBlue4"))))
 '(shadow ((t (:foreground "grey50"))))
 '(secondary-selection ((t (:background "darkslateblue"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-builtin-face ((((class grayscale) (background light)) (:weight bold :foreground "LightGray")) (((class grayscale) (background dark)) (:weight bold :foreground "DimGray")) (((class color) (min-colors 88) (background light)) (:foreground "dark slate blue")) (((class color) (min-colors 88) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 16) (background light)) (:foreground "Orchid")) (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 8)) (:weight bold :foreground "blue")) (t (:weight bold))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "color-28"))))
 '(font-lock-constant-face ((((class grayscale) (background light)) (:underline t :weight bold :foreground "LightGray")) (((class grayscale) (background dark)) (:underline t :weight bold :foreground "Gray50")) (((class color) (min-colors 88) (background light)) (:foreground "dark cyan")) (((class color) (min-colors 88) (background dark)) (:foreground "Aquamarine")) (((class color) (min-colors 16) (background light)) (:foreground "CadetBlue")) (((class color) (min-colors 16) (background dark)) (:foreground "Aquamarine")) (((class color) (min-colors 8)) (:foreground "magenta")) (t (:underline t :weight bold))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "medium slate blue"))))
 '(font-lock-keyword-face ((t (:foreground "color-38"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "Aquamarine" :inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "goldenrod"))))
 '(font-lock-type-face ((t (:foreground "LightSkyBlue2"))))
 '(font-lock-variable-name-face ((t (:foreground "wheat"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "Pink" :inherit (error)))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:underline t :foreground "RoyalBlue3"))))
 '(link-visited ((t (:foreground "magenta4" :inherit (link)))))
 '(fringe ((t (:background "Grey15"))))
 '(header-line ((t (:underline t :inverse-video nil :inherit (mode-line)))))
 '(mode-line ((t (:box (:line-width -1 :color nil :style released-button) :foreground "black" :background "white"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "black" :background "white"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:weight light :box (:line-width -1 :color "grey75" :style nil) :foreground "grey20" :background "grey90" :inherit (mode-line)))))
 '(isearch ((t (:background "RoyalBlue4" :foreground "yellow"))))
 '(isearch-fail ((t (:background "brightred"))))
 '(lazy-highlight ((t (:background "color-30"))))
 '(match ((t (:background "RoyalBlue"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))
 '(paren-face-match ((t (:background "RoyalBlue"))))
 '(ido-only-match ((t (:foreground "yellow"))))
 '(dired-directory ((t (:foreground "color-39"))))

 '(flyspell-duplicate  ((t (:foreground "color-100"))))
 '(font-latex-math-face ((t (:foreground "brightcyan"))))

 '(default ((t (:family "default" :foundry "default" :width normal :height 1 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "Grey" :background "Grey15" :stipple nil :inherit nil)))))

(provide-theme 'skymountain)
