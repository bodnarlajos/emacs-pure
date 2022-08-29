;; -*- lexical-binding: t -*-

(defvar my/dap/working-directory "" "")
(defvar my/dap/entry-point "" "")
(defvar my/dap/name "" "")

(defun my/dap/haskell-reg-auto ()
	"T."
	(interactive)
	(message "my/dap/working-directory: %s" my/dap/working-directory )
	(message "my/dap/entry-point: %s" my/dap/entry-point )
	(message "my/dap/name: %s" my/dap/name )
	(my/dap/haskell-reg my/dap/working-directory (concat my/dap/working-directory my/dap/entry-point) my/dap/name))

(defun my/dap/haskell-reg-auto-with-entry (name entry-point)
	"T."
	(interactive "sName: \nsEntry point: ")
	(message "my/dap/working-directory: %s" my/dap/working-directory )
	(message "my/dap/entry-point: %s" entry-point )
	(message "my/dap/name: %s" name )
	(my/dap/haskell-reg my/dap/working-directory (concat my/dap/working-directory entry-point) name))

(defun my/dap/haskell-reg (workdir entrypoint name)
	"Register dap template based on my/dap/... variables"

	(dap-register-debug-template name
															 (list :type "hda"
																		 :request "launch"
																		 :name name
																		 :internalConsoleOptions "openOnSessionStart"
																		 ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
																		 :workspace workdir
																		 :startup entrypoint
																		 :startupFunc ""
																		 :startupArgs ""
																		 :stopOnEntry t
																		 :mainArgs ""
																		 :ghciPrompt "H>>= "
																		 :ghciInitialPrompt "Prelude>"
																		 :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
																		 :ghciEnv (list :dummy "")
																		 :logFile (concat workdir "debug.log")
																		 :logLevel "WARNING"
																		 :forceInspect nil))
	)

(defun my/setup-lsp-capf ()
	(message "setup-lsp")
  (setq-local completion-at-point-functions
							'(lsp-completion-at-point
								cape-dabbrev
								cape-file)
							cape-dabbrev-min-length 2))

(use-package flycheck
	:hook
	(flycheck-mode . flymake-mode)
	:config
	(flycheck-add-mode 'javascript-eslint 'typescript-mode)
	(flycheck-add-mode 'html-tidy 'web-mode)
	(flycheck-add-mode 'javascript-eslint 'js2-mode)
	(flycheck-mode +1))

(use-package csharp-mode)

(use-package lsp-mode
	:hook ((c-mode          ; clangd
          c++-mode        ; clangd
          c-or-c++-mode   ; clangd
          java-mode       ; eclipse-jdtls
          js-mode         ; ts-ls (tsserver wrapper)
					haskell-mode
					csharp-mode
					mhtml-mode
          js-jsx-mode     ; ts-ls (tsserver wrapper)
          typescript-mode ; ts-ls (tsserver wrapper)
          python-mode     ; pyright
          web-mode        ; ts-ls/HTML/CSS
          haskell-mode    ; haskell-language-server
          ) . lsp-deferred)
  :commands lsp
	:bind
	("M-s l" . lsp-find-references)
	("M-s p" . lsp-ui-peek-find-references)
	("M-s i" . lsp-find-implementation)
	("M-s c" . lsp-execute-code-action)
	("M-s p" . lsp-ui-doc-show)
	("<M-left>" . lsp-ui-doc-show)
	:config
	(setq lsp-auto-guess-root t)
  (setq lsp-restart 'auto-restart)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5)
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
	:defer t)

(use-package lsp-ui
	:hook
	(lsp-mode . lsp-ui-mode)
	:config
	;; (setq lsp-log-io t)
	(custom-set-variables
	 '(lsp-ui-imenu-enable nil)
	 '(lsp-ui-sideline-enable t)
	 '(lsp-ui-sideline-show-symbol t)
	 '(lsp-headerline-breadcrumb-enable nil)
	 '(lsp-ui-peek-enable nil)))

(global-eldoc-mode +1)
(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

(defun my/append-cape-to-capf ()
	"T."
	(interactive)
	(when (not (member 'cape-file completion-at-point-functions))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-file)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-dabbrev)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-keyword)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-symbol)))
		(setq completion-at-point-functions (append completion-at-point-functions '(cape-line)))))

(use-package dap-mode
	:init
	(require 'dap-utils)
	(dap-register-debug-provider
	 "hda"
	 (lambda (conf)
		 (plist-put conf :dap-server-path (list "haskell-debug-adapter" "--hackage-version=0.0.35.0"))
		 conf))
	:config
	(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra))))

(provide 'my-dev-lsp-mode)
