(straight-use-package 'csharp-mode)

;; ;; the hook function which going to run only once
;; (defun my/csharp-dev-run ()
;; 	"csharp mode development"
;; 	(straight-use-package 'eglot)
;; 	(straight-use-package 'omnisharp)
;; 	(add-to-list 'eglot-server-programs `(csharp-mode . ("~/.emacs.d/omnisharp-linux-x64/run")))
;; 	(add-hook 'csharp-mode-hook 'eglot-ensure))

;; (my/add-dev-hook #'my/csharp-dev-run)



(provide 'my-csharp)
