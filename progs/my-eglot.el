(defun flycheck-eglot-init (checker callback)
  "Clean up errors when done.
CHECKER is the checker (eglot).
CALLBACK is the function that we need to call when we are done, on all the errors."
  (cl-labels
      ((flymake-diag->flycheck-err
        (diag)
        (with-current-buffer (flymake--diag-buffer diag)
          (flycheck-error-new-at-pos
           (flymake--diag-beg diag)
           (pcase (flymake--diag-type diag)
             ('eglot-note 'info)
             ('eglot-warning 'warning)
             ('eglot-error 'error)
             (_ (error "Unknown diagnostic type, %S" diag)))
           (flymake--diag-text diag)
           :end-pos (flymake--diag-end diag)
           :checker checker
           :buffer (current-buffer)
           :filename (buffer-file-name)))))
    ;; NOTE: Setting up eglot to automatically create flycheck errors for the buffer.
    (funcall callback 'finished
             (when eglot--unreported-diagnostics
               (let ((result nil))
                 (dolist (diag (cdr eglot--unreported-diagnostics))
                   (push (flymake-diag->flycheck-err diag) result))
                 (setq eglot--unreported-diagnostics nil)
                 result)))))

(defun flycheck-eglot-available-p ()
  (bound-and-true-p eglot--managed-mode))

(add-hook 'eglot--managed-mode-hook
          (defun eglot-prefer-flycheck-h ()
            (when eglot--managed-mode
              (when-let ((current-checker (flycheck-get-checker-for-buffer)))
                (unless (equal current-checker 'eglot)
                  (flycheck-add-next-checker 'eglot current-checker)))
              (flycheck-add-mode 'eglot major-mode)
              (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
                (flycheck-add-next-checker
                 'eglot
			           '(warning . c/c++-googlelint)))
              (flycheck-mode 1)
              (flymake-mode -1))))

(flycheck-define-generic-checker 'eglot
																 "Report `eglot' diagnostics using `flycheck'."
																 :start #'flycheck-eglot-init
																 :predicate #'flycheck-eglot-available-p
																 :modes '(prog-mode text-mode c++-mode c-mode))

(push 'eglot flycheck-checkers)

(add-hook 'eglot--managed-mode-hook #'eglot-prefer-flycheck-h)

(provide 'my-eglot)
