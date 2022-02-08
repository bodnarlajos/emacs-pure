;; -*- lexical-binding: t -*-

(defun my-web-mode ()
	"My web mode."
	(interactive)
	(my-web-mode-install)
	(my-web-mode-config))

(defun my-web-mode-install ()
	"T."
	(straight-use-package 'js2-mode)
	(straight-use-package 'typescript-mode)
	(straight-use-package 'web-mode)
	(straight-use-package 'css-mode)
	(straight-use-package 'less-css-mode)
	(straight-use-package 'scss-mode))

(defun my-web-mode-config ()
	"T."
	(add-to-list 'auto-mode-alist '("\\.julius\\'" . js2-mode))
	(add-to-list 'auto-mode-alist '("\\.hamlet\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.lucius\\'" . css-mode))
	(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
	;; (defcustom lsp-angular-language-server-command
	;; 	'("node" "/usr/local/lib/node_modules/@angular/language-server" "--ngProbeLocations" "/usr/local/lib/node_modules" "--tsProbeLocations" "/usr/local/lib/node_modules" "--stdio")
	;; 	"The command that starts the docker language server."
	;; 	:group 'lsp-angular
	;; 	:type '(choice
	;; 					(string :tag "Single string value")
	;; 					(repeat :tag "List of string values"
	;; 									string)))
	
	(defun my/web-dev-run ()
		"Web mode development."
		(flycheck-add-mode 'javascript-eslint 'typescript-mode)
		(flycheck-add-mode 'javascript-eslint 'web-mode)
		(add-hook 'js-mode-hook #'lsp)
		(add-hook 'typescript-mode-hook #'lsp)
		(add-hook 'js2-mode-hook #'lsp)
		(add-hook 'web-mode-hook #'lsp))
		
		
		;; (lsp-register-client
		;;  (make-lsp-client :new-connection (lsp-stdio-connection
		;; 																	 (-const lsp-clients-angular-language-server-command))
		;; 									:activation-fn (lambda (&rest _args)
		;; 																	 (string-match-p ".*\.html$" (buffer-file-name)) )
		;; 									:add-on? t
		;; 									:priority -1
		;; 									:server-id 'my-angular-ls)))
		;; (defun hack-local-ls-command ()
		;; 	"T."
		;; 	(let* ((projroot (project-root (project-current)))
		;; 				 (probeLocation (concat "/usr/local/lib/node_modules" "," projroot)))
		;; 		(message "%s" probeLocation)
		;; 		(customize-variable
		;; 		 '(lsp-clients-angular-language-server-command
		;; 			 '("node" "/usr/local/lib/node_modules/@angular/language-server" "--ngProbeLocations" "/usr/local/lib/node_modules,~/Projects/courses/" "--tsProbeLocations" "/usr/local/lib/node_modules,~/Projects/courses/" "--stdio")))
		;; 		(lsp)))
		;; (add-hook 'hack-local-variables-hook
		;; 					(lambda () (when (derived-mode-p 'typescript-mode) (hack-local-ls-command))))
		;; (add-hook 'hack-local-variables-hook
		;; 					(lambda () (when (derived-mode-p 'web-mode) (hack-local-ls-command))))
		;; (add-hook 'hack-local-variables-hook
		;; 					(lambda () (when (derived-mode-p 'html-mode) (hack-local-ls-command)))))
	(with-eval-after-load 'typescript-mode
		(setq-default typescript-indent-level 2))

	(with-eval-after-load 'web-mode
		(custom-set-variables
		 '(web-mode-code-indent-offset 2)
		 '(web-mode-markup-indent-offset 2)
		 '(web-mode-sql-indent-offset 2)))
	(with-eval-after-load 'css-mode
		(custom-set-variables 
		 '(web-mode-css-indent-offset 2)))
	
	(my/add-dev-hook #'my/web-dev-run))

(provide 'my-web)
