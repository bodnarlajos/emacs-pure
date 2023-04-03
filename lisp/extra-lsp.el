;; -*- lexical-binding: t -*-

(use-package lsp-mode)
(use-package dap-mode
  :config
  (dap-register-debug-provider
   "hda"
   (lambda (conf)
     (plist-put conf :dap-server-path (list "haskell-debug-adapter" "--hackage-version=0.0.35.0"))
     conf)))
(use-package consult-lsp)
;; lsp-languages
(use-package lsp-haskell)

(add-hook 'csharp-mode-hook 'lsp-deferred)
(add-hook 'js2-mode-hook 'lsp-deferred)
(add-hook 'typescript-mode-hook 'lsp-deferred)
(add-hook 'web-mode-hook 'lsp-deferred)
(add-hook 'haskell-mode-hook 'lsp-deferred)

(defun my/dap/check-mode-and-load-dap ()
  "Check the major mode and load the necessary dap module"
  (message "Check dap module")
  (when (eq major-mode 'csharp-mode)
    (require 'dap-netcore)))

(with-eval-after-load 'dap-mode
  (setq dap-auto-configure-features '(locals controls tooltip))
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))
  (add-hook 'dap-mode-hook #'my/dap/check-mode-and-load-dap))

(defun my/lsp-mode-hook ()
  "t."
  (setq eldoc-documentation-functions
        (cons #'flymake-eldoc-function
              (remove #'flymake-eldoc-function eldoc-documentation-functions)))
  ;; Show all eldoc feedback.
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose)
  (custom-set-variables
   '(lsp-completion-provider :none)
   '(lsp-diagnostics-provider :flymake)
   '(lsp-headerline-breadcrumb-enable nil))
  (setf (caadr ;; Pad before lsp modeline error info
	 (assq 'global-mode-string mode-line-misc-info))
	" "))

(add-hook 'lsp-mode-hook #'my/lsp-mode-hook)
(add-hook 'lsp-completion-mode-hook #'my/setup-lsp-capf)
(add-hook 'lsp-completion-mode-hook
	  (lambda ()
	    (setf (alist-get 'lsp-capf completion-category-defaults) '((styles . (orderless))))))

(defun my/setup-lsp-capf ()
  (setq-local completion-at-point-functions
	      '(lsp-completion-at-point
		cape-dabbrev
		cape-file)
	      cape-dabbrev-min-length 2))

(with-eval-after-load 'lsp-mode
  (setq lsp-auto-guess-root t)
  (setq lsp-restart 'auto-restart)
  (setq lsp-modeline-diagnostics-mode t)
  (setq lsp-diagnostics-provider :none)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5)
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-eldoc-render-all t)
  (setq lsp-log-io nil)
  (setq lsp-headerline-breadcrumb-enable nil))

;; the .dir-locals.el file should be in this form
;; ((nil . ((my/dap/working-directory . "/home/lbodnar/Projects/sevenqueens/")
;; 	 (my/dap/entry-point . "app/Main.hs")
;; 	 (my/dap/name . "dap-haskell-sevenqueens"))))

(defvar my/dap/working-directory "" "The haskell project working directory")
(defvar my/dap/entry-point "" "The haskell function as entry point")
(defvar my/dap/name "haskell-dap" "The name of the configuration")

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
				     :ghciInitialPrompt "ghci>"
				     :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
				     :ghciEnv (list :dummy "")
				     :logFile (concat workdir "debug.log")
				     :logLevel "WARNING"
				     :forceInspect nil)))

(provide 'extra-lsp)
