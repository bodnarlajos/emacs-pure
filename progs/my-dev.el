;; -*- lexical-binding: t -*-

(use-package eglot)

(use-package consult-eglot)

(use-package flymake
	:config
	(add-hook 'eglot-managed-mode-hook 'flymake-mode))

(use-package csharp-mode)

(use-package lsp-java
	:straight t
	:defer t)

(global-eldoc-mode +1)

(provide 'my-dev)
