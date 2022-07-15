;; -*- lexical-binding: t -*-

(require 'my-dev)

(use-package js2-mode)
(use-package typescript-mode
	:init
	(add-hook 'typescript-mode-hook #'eglot-ensure))
(use-package css-mode)
(use-package less-css-mode)
(use-package scss-mode)
(use-package web-mode
	:init
	(add-hook 'web-mode-hook #'eglot-ensure)
	:config
	(add-hook 'html-mode-hook 'web-mode)
	(add-hook 'web-mode-hook (lambda ()
														 (message "M-m ]")
														 (local-set-key (kbd "M-m ]") 'web-mode-fold-or-unfold))))

(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq-default typescript-indent-level 2)
(custom-set-variables
 '(css-indent-offset 2)
 '(js-indent-level 2))
	
(provide 'my-web)
