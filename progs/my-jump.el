;; -*- lexical-binding: t -*-

(straight-use-package 'dumb-jump)

(with-eval-after-load 'dumb-jump
	(custom-set-variables
	 '(dumb-jump-max-find-time 5)
	 '(dumb-jump-selector 'completing-read)
	 '(dumb-jump-preferred-searcher 'rg)))

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)

(provide 'my-jump)
