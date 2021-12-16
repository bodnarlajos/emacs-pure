;; -*- lexical-binding: t -*-

;; helper functions for ide-mode
(defun my/run-dev-hook ()
	"T."
	(when (and (not my/dev-env) my/dev-hook)
		(run-hooks 'my/dev-hook)
		(setq my/dev-env t)))

(defun my/add-dev-hook (fv)
	"Add or run a function when dev mode is active or not"
	(if my/dev-env
			(funcall fv)
		(add-hook 'my/dev-hook fv)))

(defun my/start/devenv ()
	"T."
	(interactive)
	(my/run-dev-hook)
	(my/revert-current-buffer))
;; end of the helper functions of ide-mode

;; beginning of the ide-mode customization
(add-hook 'my/dev-hook (lambda ()
												 (straight-use-package 'lsp-mode)
												 (straight-use-package 'lsp-ui)
												 (custom-set-variables
													'(lsp-ui-doc-show-with-cursor t))))
;; end of the ide-mode customization

;; the custom prog mode
(defun my/local-prog-mode ()
	"T."
	(setq-local tab-width 2)
	(display-line-numbers-mode)
	(highlight-indent-guides-mode t)
	(diminish 'highlight-indent-guides-mode-hook)
	(diff-hl-mode t)
	(smartparens-mode +1))
(add-hook 'prog-mode-hook 'my/local-prog-mode)

(provide 'my-dev)
