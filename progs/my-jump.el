(straight-use-package 'dumb-jump)

(with-eval-after-load 'dumb-jump
	(setq dumb-jump-selector 'popup
				dumb-jump-preferred-searcher 'rg)
	(global-set-key (kbd "<f12>") 'dumb-jump-go)
	(global-set-key (kbd "<C-f12>") 'dumb-jump-back)
	(custom-set-variables
	 '(dumb-jump-max-find-time 5))
	(add-hook 'xref-backend-functions #'dumb-jump-xref-activate))
