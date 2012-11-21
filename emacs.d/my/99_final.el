; keybinds
(global-keybinds-define-keybinds global-map)

; color theme
(if (< emacs-major-version 24)
    (progn
      (require 'color-theme)
      (add-to-list 'color-themes '(my-color-theme  "TARO SEKIYAMA" "color-theme-sky-gray"))
      (color-theme-initialize)
      (color-theme-install (my-color-theme)))
    (progn
      (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/my/themes"))
      (load-theme 'skymountain t)))
