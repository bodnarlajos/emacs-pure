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
	(when (buffer-file-name)
		(my/revert-current-buffer)))

;; end of the helper functions of ide-mode

(defun my/setup-lsp-capf ()
	(message "setup-lsp")
  (setq-local completion-at-point-functions
							'(lsp-completion-at-point
								cape-dabbrev
								cape-file)
							cape-dabbrev-min-length 2))

(use-package flycheck
	:straight t
	:defer t
	:config
	(flycheck-mode +1))

(use-package lsp-mode
	:straight t
	:defer t
	:bind
	("M-s l" . lsp-find-references)
	("M-s p" . lsp-ui-peek-find-references)
	("M-s i" . lsp-find-implementation)
	:config
	(custom-set-variables
	 '(lsp-disabled-clients
		 '(eslint html-ls)))
	(setq lsp-client-packages '(lsp-angular lsp-javascript lsp-eslint lsp-css lsp-xml lsp-java lsp-json lsp-haskell lsp-csharp lsp-html lsp-javascript lsp-eslint)
				lsp-headerline-breadcrumb-enable nil
				lsp-completion-provider :none
				lsp-enable-snippet nil)
	(add-hook 'lsp-mode-hook
						(lambda ()
							(display-line-numbers-mode +1)
							(setf (caadr ;; Pad before lsp modeline error info
										 (assq 'global-mode-string mode-line-misc-info))
										" ")))
	(add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
	(add-hook 'lsp-completion-mode-hook
						(lambda ()
							(setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless)))))))

(use-package lsp-java
	:straight t
	:defer t)

(use-package lsp-ui
	:straight t
	:defer t
	:init (lsp-ui-mode +1)
	:config
	;; (setq lsp-log-io t)
	(lsp-ui-sideline-mode -1)
	(custom-set-variables
	 '(lsp-ui-imenu-enable nil)
	 '(lsp-ui-sideline-enable nil)
	 '(lsp-ui-peek-enable nil)))

(global-eldoc-mode +1)
(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

(my/add-dev-hook 'my/start/restclient)

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
