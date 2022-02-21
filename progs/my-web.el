;; -*- lexical-binding: t -*-

(defun my-web-mode ()
	"My web mode."
	(interactive)
	(my-web-mode-install)
	(my-web-mode-config))

(defun my-web-mode-install ()
	"T."
	(straight-use-package 'js2-mode)
	(straight-use-package 'typescript-mode)
	(straight-use-package 'web-mode)
	(straight-use-package 'css-mode)
	(straight-use-package 'less-css-mode)
	(straight-use-package 'scss-mode))

(defun my-web-mode-config ()
	"T."
	(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
	(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))
	(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
	(custom-set-variables
	 '(css-indent-offset 2)
	 '(js-indent-level 2)
	 '(web-mode-code-indent-offset 2)
	 '(web-mode-css-indent-offset 2)
	 '(web-mode-markup-indent-offset 2))

	(defun my/web-dev-run ()
		"Web mode development."
		(flycheck-add-mode 'javascript-eslint 'typescript-mode)
		(flycheck-add-mode 'javascript-eslint 'web-mode)
		(add-hook 'js-mode-hook #'lsp)
		(add-hook 'typescript-mode-hook #'lsp)
		(add-hook 'js2-mode-hook #'lsp)
		(add-hook 'web-mode-hook #'lsp))
	
	(with-eval-after-load 'typescript-mode
		(setq-default typescript-indent-level 2))

	(with-eval-after-load 'web-mode
		(custom-set-variables
		 '(web-mode-code-indent-offset 2)
		 '(web-mode-markup-indent-offset 2)
		 '(web-mode-sql-indent-offset 2)))
	(with-eval-after-load 'css-mode
		(custom-set-variables 
		 '(web-mode-css-indent-offset 2)))
	
	(my/add-dev-hook #'my/web-dev-run))

(provide 'my-web)
