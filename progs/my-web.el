(straight-use-package 'web-mode)
(straight-use-package 'less-css-mode)

(my/load-my "dev")

;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "jsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))

(my/installed "web")
