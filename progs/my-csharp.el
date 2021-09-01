(straight-use-package 'csharp-mode)
(straight-use-package 'eglot)

(defun start-omni-eglot ()
	""
	(interactive)
	(eglot-ensure)
	(add-to-list 'eglot-server-programs `(csharp-mode . ("/home/lbodnar/.emacs.d/omnisharp/run" "-lsp"))))

(provide 'my-csharp)
