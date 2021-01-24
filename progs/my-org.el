(with-eval-after-load 'org
	(setq org-todo-keywords
				'((sequence "TODO" "INFO" "WIP" "|" "DONE"))
				org-support-shift-select t)
	(define-key org-mode-map (kbd "<M-return>") 'find-file-at-point))

(straight-use-package 'org)

(my/installed "org")
