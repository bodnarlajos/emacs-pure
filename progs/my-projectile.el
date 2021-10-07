;; -*- lexical-binding: t -*-

(straight-use-package 'projectile)
;; (straight-use-package 'counsel-projectile)
;; (my/load-my "ivy")

(with-eval-after-load 'projectile
	(setq projectile-project-search-path my/project-dir
				projectile-mode-line-prefix ""
        projectile-sort-order 'recentf
        projectile-use-git-grep t))

(add-hook 'projectile-mode-hook (lambda ()
																	(local-set-key (kbd "C-o") 'projectile-find-file)
																	(local-set-key (kbd "C-b") 'projectile-switch-to-buffer)
																	(local-set-key (kbd "C-c C-c") 'projectile-compile-project)
																	(local-set-key (kbd "C-c k") 'kill-compilation)))

(add-hook 'prog-mode-hook 'projectile-mode)

(message "my-projectile is ...")
(my/installed "projectile")
(provide 'my-projectile)
