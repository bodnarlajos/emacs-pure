(with-eval-after-load 'haskell-mode
	(require 'yasnippet)
	(setq compilation-scroll-output t)
	(custom-set-variables
	 '(haskell-compiler-type 'stack))
	(setq eldoc-echo-area-use-multiline-p 1)
	(add-hook 'haskell-mode-hook (lambda ()
																 (local-unset-key (kbd ";"))
																 (local-set-key (kbd "C-c C-c") 'haskell-compile)
																 (my/prog-mode)
																 (eglot-ensure))))

(add-to-list 'auto-mode-alist '("\\.hamlet" . shakespeare-hamlet-mode))
(add-to-list 'auto-mode-alist '("\\.julius" . shakespeare-julius-mode))
(add-to-list 'auto-mode-alist '("\\.lucius" . shakespeare-lucius-mode))

(with-eval-after-load 'shakespeare-julius-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'shakespeare-lucius-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'shakespeare-hamlet-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'html-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'css-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'js2-mode
	(add-hook 'html-mode-hook 'my/prog-mode))
(with-eval-after-load 'flymake
	(local-set-key (kbd "C-n") 'flymake-goto-next-error)
	(local-set-key (kbd "C-p") 'flymake-goto-prev-error)
	(load-my "flymake-diagnostic-at-point")
	(add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(defun my/prog-mode ()
	"T."
	(interactive)
	(setq-local tab-width 2)
	(display-line-numbers-mode)
	(highlight-indent-guides-mode)
	(company-mode))

(provide 'my-eglot)
