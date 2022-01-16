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
(defun my/setup-lsp-capf ()
	(message "setup-lsp")
  (setq-local completion-at-point-functions
							`(,(cape-super-capf
									(cape-capf-with-predicate
									 #'lsp-completion-at-point
									 #'my/ignore-elisp-keywords)
									#'cape-dabbrev)
								cape-file)
							cape-dabbrev-min-length 3))
(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

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
																					 " ")
																		 (message "lsp2")))
												 (add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
												 (add-hook 'lsp-completion-mode-hook
																	 (lambda ()
																		 (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))
																		 (message "lsp1")))
												 ;; (straight-use-package 'eldoc-box)
												 (global-eldoc-mode +1)))
												 ;; (add-hook 'lsp-mode-hook 'eldoc-box-hover-mode +1)))
;; end of the ide-mode customization
(defun my/append-cape-to-capf ()
	"T."
	(interactive)
	(when (not (member 'cape-file completion-at-point-functions))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-file)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-dabbrev)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-keyword)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-symbol)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-line)))))

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
