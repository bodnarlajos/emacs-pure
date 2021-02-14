(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-unset-key (kbd "C-c d"))
(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key (kbd "C-c l") 'recenter)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-`") 'window-toggle-side-windows)
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-M-<return>") 'find-file-literally-at-point)
(global-set-key (kbd "C-c m") 'execute-extended-command)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c i") 'indent-buffer)
(global-set-key (kbd "C-c j") 'helm-all-mark-rings)
(global-set-key (kbd "C-o") 'helm-find-files)
(global-set-key (kbd "M-<return>") 'ffap)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-l") 'my/menu-base)
(global-set-key (kbd "C-b") 'helm-buffers-list)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-<return>") 'ffap))

(with-eval-after-load 'helm-rg
	(define-key helm-rg-map (kbd "M-e") 'wgrep-change-to-wgrep-mode))

(provide 'my-keys)
