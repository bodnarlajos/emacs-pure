;; -*- lexical-binding: t -*-

(defun my-web-mode ()
	"My web mode."
	(interactive)
	(use-package js2-mode
		:straight t)
	(use-package typescript-mode
		:straight t)
	(use-package css-mode
		:straight t)
	(use-package less-css-mode
		:straight t)
	(use-package scss-mode
		:straight t)
	(use-package web-mode
		:straight t
		:config
		(add-hook 'html-mode-hook 'web-mode)
		(add-hook 'web-mode-hook (lambda ()
															 (message "M-m ]")
															 (local-set-key (kbd "M-m ]") 'web-mode-fold-or-unfold))))
	
	(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
	(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))
	(setq-default typescript-indent-level 2)
	(custom-set-variables
	 '(css-indent-offset 2)
	 '(js-indent-level 2))

	(defun my/web-dev-run ()
		"Web mode development."
		(flycheck-add-mode 'javascript-eslint 'typescript-mode)
		(flycheck-add-mode 'html-tidy 'web-mode)
		(flycheck-add-mode 'javascript-eslint 'js2-mode)
		(add-hook 'js-mode-hook #'lsp)
		(add-hook 'typescript-mode-hook #'lsp)
		(add-hook 'web-mode-hook #'lsp)
		(add-hook 'js2-mode-hook #'lsp))

	(my/add-dev-hook #'my/web-dev-run))

(provide 'my-web)
