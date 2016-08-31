; c common style
(defun cpp-custom-indent(elem)
  (let* ((point (c-langelem-pos elem))
         (word-at-point (save-excursion
                          (goto-char point)
                          (thing-at-point 'word))))
    (cond
     ((string= "typedef" word-at-point) '+)
     (t 0))))

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (require 'cpp-complt nil t)
              (cpp-complt-init))

            (c-set-style "gnu")
            (setq comment-start-skip "*")
            (c-toggle-hungry-state 1)

            (c-set-offset 'innamespace 0)
            (c-set-offset 'arglist-close 0)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'inline-open 0)
            (c-set-offset 'topmost-intro-cont 'cpp-custom-indent)

            (let ((maps (list c-mode-map c++-mode-map)))
              (dolist (map maps)
                (global-keybinds-define-keybinds map)
                (define-keybinds map
                  '(("#"         cpp-complt-instruction-completing)
                    ("C-c #"     cpp-complt-ifdef-region)
                    ("C-c #"     cpp-complt-ifdef-region)
                    ("C-c C-e"   end-of-buffer)
                    ("C-c C-b"   beginning-of-buffer)
                    ("C-c m"     c-macro-expand)
                    ("C-t"       ff-find-other-file)
                    ("C-c C-M-c" uncomment-region)))))
            ))

; c++-mode
(add-hook 'c++-mode-hook
          (lambda ()
            (setq comment-start "// ")
            (setq comment-end   "")
            ))

; include path
(if (boundp 'header-dirs)
    (setq cpp-complt-standard-header-path header-dirs))

; allocate *.h and *.c to c++ mode
(add-to-list 'auto-mode-alist '("\\.[hc]$" . c++-mode))

; auto insert
(auto-insert-register
 "\\.hpp$" [ "template.hpp" auto-insert-dynamically ]
 '(("%HEADER_GUARD%" .
    (lambda ()
      (or (let ((entries (entries-to-vc-dir
                          (file-name-sans-extension buffer-file-name))))
            (when entries
              (upcase (concat "_" (join "_" entries)))))
          "FAIL")))
   ("%NAMESPACE%" .
    (lambda ()
      (or (let ((entries (entries-to-vc-dir
                          (file-name-directory-sans-slash buffer-file-name))))
            (when entries
              (let ((namespace-open
                     (join " " (mapcar
                                (lambda (entry) (format "namespace %s {" entry))
                                entries)))
                    (namespace-close
                     (concat (string-repeat "}" (length entries))
                             " // namespace "
                             (join "::" entries))))
                (concat namespace-open "\n" namespace-close))))
          "FAIL")))
   ))

(defun cpp-insert-test-code ()
  (interactive)
  (overwrite-file-contents (expand-file-name "~/.emacs.d/conf/template/test.cpp")))

(flymake-add-allowed-file-name-masks
 "\\.\\([ch]pp\\)\\|[ch]$"
 (flymake-make-init-on-the-fly
  "clang++" '("-Wall"
              "-Wextra"
              "-Winit-self"
              "-fsyntax-only"
              "-std=c++11"
              "-stdlib=libc++"
          )))

(add-hook 'c++-mode-hook
          (lambda ()
            (flymake-mode t)
            ))
