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
												 (setq lsp-headerline-breadcrumb-enable nil)
												 (setq lsp-completion-provider :none)
												 (setq lsp-ui-imenu-enable t)
												 (setq lsp-ui-sideline-enable t)
												 (setq lsp-ui-sideline-show-diagnostics t)
												 (setq lsp-ui-sideline-show-hover nil)
												 (setq lsp-enable-snippet nil)
												 (setq lsp-ui-sideline-show-symbol nil)
												 (setq lsp-ui-sideline-show-code-actions t)
												 (setq lsp-ui-sideline-diagnostic-max-lines 5)
												 (setq lsp-ui-peek-enable nil)
												 (setq lsp-ui-doc-enable t)
												 (setq lsp-ui-doc-show-with-mouse t)
												 (setq lsp-ui-doc-show-with-cursor nil)
	
												 (add-hook 'lsp-mode-hook
																	 (lambda ()
																		 (setf (caadr ;; Pad before lsp modeline error info
																						(assq 'global-mode-string mode-line-misc-info))
																					 " ")))

												 (add-hook 'lsp-completion-mode-hook
																	 (lambda ()
																		 (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))))

												 (straight-use-package 'eldoc-box)
												 (global-eldoc-mode +1)
												 (add-hook 'lsp-mode-hook 'eldoc-box-hover-mode +1)))

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
