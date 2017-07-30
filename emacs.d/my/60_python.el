;; we have to install the following packages to use elpy fully
;;   rope or jedi  # completion
;;   flake8        # code checks
;;   importmagic   # automatic imports
;;   autopep8      # automatic PEP8 formatting
;;   yapf          # code formatting

(elpy-enable)

(add-hook 'elpy-mode-hook
          (lambda ()
            (define-keybinds elpy-mode-map
              '(("C-c C-b" beginning-of-buffer)
                ("C-c C-e" end-of-buffer)
                ))
            ))
