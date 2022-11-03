;; -*- lexical-binding: t -*-

(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-java)
(straight-use-package 'consult-lsp)

(global-set-key (kbd "M-s l") 'lsp-find-references)
(global-set-key (kbd "M-s i") 'lsp-find-implementation)
(global-set-key (kbd "M-s c") 'lsp-execute-code-action)
(setq lsp-auto-guess-root t)
(setq lsp-restart 'auto-restart)
(setq lsp-modeline-diagnostics-mode t)
(setq lsp-diagnostics-provider :none)
(setq read-process-output-max (* 1024 1024)) ;; 1MB
(setq lsp-idle-delay 0.5)
(setq lsp-log-io nil)

(defun my/dap/check-mode-and-load-dap ()
  "Check the major mode and load the necessary dap module"
  (message "Check dap module")
  (when (eq major-mode 'csharp-mode)
    (require 'dap-netcore)))

(with-eval-after-load 'dap-mode
  (setq dap-auto-configure-features '(locals controls tooltip))
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))
  (add-hook 'dap-mode-hook #'my/dap/check-mode-and-load-dap))


(add-hook 'lsp-mode-hook
	  (lambda ()
            (custom-set-variables
             '(lsp-completion-provider :none)
             '(lsp-headerline-breadcrumb-enable nil))
	    (display-line-numbers-mode +1)
	    (setf (caadr ;; Pad before lsp modeline error info
		   (assq 'global-mode-string mode-line-misc-info))
		  " ")))
(add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
(add-hook 'lsp-completion-mode-hook
	  (lambda ()
	    (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))))

(defun my/setup-lsp-capf ()
  (setq-local completion-at-point-functions
	      '(lsp-completion-at-point
		cape-dabbrev
		cape-file)
	      cape-dabbrev-min-length 2))

(with-eval-after-load 'lsp-mode
  (setq lsp-headerline-breadcrumb-enable nil))

(provide 'extra-lsp)
