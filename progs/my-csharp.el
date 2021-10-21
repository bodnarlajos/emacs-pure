;; -*- lexical-binding: t -*-

(straight-use-package 'csharp-mode)

(my/add-dev-hook (lambda ()
									 (add-hook 'csharp-mode-hook #'lsp)))
(provide 'my-csharp)
