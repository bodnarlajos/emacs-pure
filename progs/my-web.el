(straight-use-package 'js2-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'web-mode)
(straight-use-package 'css-mode)
(straight-use-package 'less-css-mode)

(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))

(defun my/web-dev-run ()
	"web mode development"
	(add-hook 'js-mode-hook 'eglot-ensure)
	(add-hook 'typescript-mode-hook 'eglot-ensure)
	(add-hook 'js2-mode-hook 'eglot-ensure))

(eval-after-load 'typescript-mode
	(setq-default typescript-indent-level 2))

(my/add-dev-hook #'my/web-dev-run)

(provide 'my-web)
