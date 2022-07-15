;; -*- lexical-binding: t -*-

(use-package eglot
	:demand t
	:ensure t
	:config
	(add-to-list 'eglot-server-programs `(web-mode . ("node" "/home/lbodnar/node_modules/@angular/language-server" "--ngProbeLocations" "/home/lbodnar/node_modules/lib/node_modules" "--tsProbeLocations" "/home/lbodnar/node_modules/lib/node_modules" "--stdio")))
	(add-to-list 'eglot-server-programs `(typescript-mode . ("node" "/home/lbodnar/node_modules/.bin/typescript-language-server" "--stdio")))
)

(use-package consult-eglot
	:ensure t)

(use-package flymake
	:config
	(add-hook 'eglot-managed-mode-hook 'flymake-mode))

(use-package csharp-mode
	:ensure t)

(use-package lsp-java
	:straight t
	:defer t)

(global-eldoc-mode +1)

(provide 'my-dev)
