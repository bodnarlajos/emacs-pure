(straight-use-package 'js2-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'web-mode)
(straight-use-package 'css-mode)
(straight-use-package 'less-css-mode)

(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))

(defun my/web-dev-run ()
	"haskell mode development"
	(interactive)
	(straight-use-package 'tide)
	(defun setup-tide-mode ()
		(interactive)
		(tide-setup)
		(flycheck-mode +1)
		(setq flycheck-check-syntax-automatically '(save mode-enabled))
		(eldoc-mode +1)
		(tide-hl-identifier-mode +1))

	(add-hook 'js2-mode-hook #'setup-tide-mode)
	;; (setq company-tooltip-align-annotations t)
	(setq-default typescript-indent-level 2)
	(add-hook 'typescript-mode-hook #'setup-tide-mode))

;; (add-hook 'typescript-mode-hook (lambda ()
;; 																	(tide-setup)
;; 																	(flycheck-mode +1)
;; 																	(setq flycheck-check-syntax-automatically '(save mode-enabled))
;; 																	(eldoc-mode +1)
;; 																	(lsp-ui-mode)))

(if my/dev-env
		(my/web-dev-run)
	(add-hook 'my/dev-hook 'my/web-dev-run))

(provide 'my-web)
