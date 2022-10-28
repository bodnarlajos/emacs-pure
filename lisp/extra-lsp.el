;; -*- lexical-binding: t -*-

;; (straight-use-package 'flycheck)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-java)
(straight-use-package 'consult-lsp)

;; (require 'flycheck)
;; (add-hook 'flycheck-mode-hook (lambda () (flymake-mode -1)))
;; (flycheck-add-mode 'javascript-eslint 'typescript-mode)
;; (flycheck-add-mode 'html-tidy 'web-mode)
;; (flycheck-add-mode 'javascript-eslint 'js2-mode)
;; (flycheck-mode +1)

(add-hook 'c-mode-hook 'lsp-deferred)          ; clangd
(add-hook 'c++-mode 'lsp-deferred)
(add-hook 'c-or-c++-mode 'lsp-deferred)
(add-hook 'java-mode 'lsp-deferred)
(add-hook 'js-mode 'lsp-deferred)
(add-hook 'haskell-mode 'lsp-deferred)
(add-hook 'csharp-mode 'lsp-deferred)
(add-hook 'mhtml-mode 'lsp-deferred)
(add-hook 'js-jsx-mode 'lsp-deferred)
(add-hook 'typescript-mode 'lsp-deferred)
(add-hook 'python-mode 'lsp-deferred)
(add-hook 'web-mode 'lsp-deferred)
(add-hook 'haskell-mode 'lsp-deferred)
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
(add-hook 'lsp-mode-hook
	  (lambda ()
	    (display-line-numbers-mode +1)
	    (setf (caadr ;; Pad before lsp modeline error info
		   (assq 'global-mode-string mode-line-misc-info))
		  " ")))
(add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
(add-hook 'lsp-completion-mode-hook
	  (lambda ()
	    (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))))

(defun my/setup-lsp-capf ()
  (message "setup-lsp")
  (setq-local completion-at-point-functions
	      '(lsp-completion-at-point
		cape-dabbrev
		cape-file)
	      cape-dabbrev-min-length 2))

(provide 'extra-lsp)
