(defun my-long-line ()
	"T."
	(interactive)
	(so-long)
	(my/load-my "longlines")
	(longlines-mode))

(add-hook 'nxml-mode-hook 'my-long-line)
(add-hook 'json-mode-hook 'my-long-line)

(provide 'my-long)
