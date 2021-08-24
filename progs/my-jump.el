(straight-use-package 'dumb-jump)

(with-eval-after-load 'dumb-jump
	(custom-set-variables
	 '(dumb-jump-max-find-time 5)
	 '(dumb-jump-selector 'completing-read)
	 '(dumb-jump-preferred-searcher 'rg)))
	
(provide 'my-jump)
