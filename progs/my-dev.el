;; -*- lexical-binding: t -*-

;; helper functions for ide-mode
(defun my/run-dev-hook ()
	"T."
	(when (and (not my/dev-env) my/dev-hook)
		(my/before-dev-hook)
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
							'(lsp-completion-at-point
								cape-dabbrev
								cape-file)
							cape-dabbrev-min-length 2))

;; beginning of the ide-mode customization
(defun my/before-dev-hook ()
	"T."
	(straight-use-package 'flycheck)
	(flycheck-mode +1)
	(straight-use-package 'lsp-mode)
	(straight-use-package 'lsp-ui)
	(lsp-ui-mode +1)
	(custom-set-variables
	 '(lsp-ui-imenu-enable nil)
	 '(lsp-ui-peek-enable nil)
	 '(lsp-ui-sideline-actions-icon "")
	 '(lsp-ui-sideline-ignore-duplicate t)
	 '(lsp-ui-sideline-show-code-actions t)
	 '(lsp-ui-sideline-show-hover t)
	 '(lsp-ui-sideline-update-mode 'line))
	;; (custom-set-variables
	;; 	 '(lsp-disabled-clients
	;; 		 '((web-mode . angular-ls) (html-mode . angular-ls))))
	(setq lsp-client-packages '(lsp-angular lsp-css lsp-xml lsp-json lsp-csharp lsp-html lsp-javascript lsp-eslint))
	(setq lsp-headerline-breadcrumb-enable nil)
	(setq lsp-completion-provider :none)
	(setq lsp-enable-snippet nil)
	
	(add-hook 'lsp-mode-hook
						(lambda ()
							(setf (caadr ;; Pad before lsp modeline error info
										 (assq 'global-mode-string mode-line-misc-info))
										" ")))
	(add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
	(add-hook 'lsp-completion-mode-hook
						(lambda ()
							(setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))))
	(global-eldoc-mode -1)
	
	(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp))

(defun my/append-cape-to-capf ()
	"T."
	(interactive)
	(when (not (member 'cape-file completion-at-point-functions))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-file)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-dabbrev)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-keyword)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-symbol)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-line)))))

(provide 'my-dev)
