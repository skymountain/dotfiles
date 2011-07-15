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
	    (require 'cpp-complt)
	    (cpp-complt-init)

	    (c-set-style "gnu")
	    (setq comment-start-skip "*")
	    (c-toggle-hungry-state 1)

      (c-set-offset 'innamespace 0)
      (c-set-offset 'arglist-close 0)
      (c-set-offset 'arglist-intro '+)
      (c-set-offset 'topmost-intro-cont 'cpp-custom-indent)

	    (let ((maps (list c-mode-map c++-mode-map)))
	      (dolist (map maps)
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
            (highlight-line-over-limit 'c++-mode 80)
            ))

; include path
(if (boundp 'header-dirs)
    (setq cpp-complt-standard-header-path header-dirs))

; allocate *.h to c++ mode
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

; auto insert
(auto-insert-register
 "\\.hpp$" [ "template.hpp" auto-insert-dynamically ]
 '(("%HEADER_GUARD%" .
    (lambda ()
      (or (let* ((entries-owned-in-top '(".git"))
                 (dir     (file-name-directory buffer-file-name))
                 (top-dir (find-ceiling-directory-entries-or
                           dir
                           entries-owned-in-top)))
            (when top-dir
              (let* ((rel-dir (upcase
                               (substring
                                (file-name-sans-extension buffer-file-name)
                                (1+ (length top-dir)))))
                     (entries (and (not (string= rel-dir ""))
                                   (split "/" rel-dir))))
                (when entries (concat "_" (join "_" entries))))))
          "FAIL")))
   ))

(defun cpp-insert-test-code ()
  (interactive)
  (overwrite-file-contents (expand-file-name "~/.emacs.d/conf/template/test.cpp")))
