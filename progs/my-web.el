;; -*- lexical-binding: t -*-

(defun my-web-mode ()
	"My web mode."
	(interactive)
	(straight-use-package 'js2-mode)
	(straight-use-package 'typescript-mode)
	(straight-use-package 'css-mode)
	(straight-use-package 'less-css-mode)
	(straight-use-package 'scss-mode)
	(straight-use-package 'ng2-mode)
	(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
	(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . ng2-html-mode))
	(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))
	(setq-default typescript-indent-level 2)
	(custom-set-variables
	 '(css-indent-offset 2)
	 '(js-indent-level 2))

	(defun my/web-dev-run ()
		"Web mode development."
		(flycheck-add-mode 'javascript-eslint 'typescript-mode)
		(flycheck-add-mode 'html-tidy 'ng2-html-mode)
		(flycheck-add-mode 'javascript-eslint 'ng2-ts-mode)
		(add-hook 'js-mode-hook #'lsp)
		(add-hook 'typescript-mode-hook #'lsp)
		(add-hook 'js2-mode-hook #'lsp)
		(add-hook 'ng2-html-mode-hook 'lsp)
		(add-hook 'ng2-ts-mode-hook #'lsp))

	(my/add-dev-hook #'my/web-dev-run))

(provide 'my-web)
