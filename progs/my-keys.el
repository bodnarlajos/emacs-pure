(straight-use-package 'project)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-c C-r") 'copy-to-register)
(global-set-key (kbd "C-c C-v") 'consult-register)
(global-unset-key (kbd "C-c d"))
(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-c n") 'move-line-down)
(global-set-key (kbd "C-c p") 'move-line-up)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "M-f") 'ctrlf-forward-regexp)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key (kbd "C-c l") 'recenter)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-`") 'window-toggle-side-windows)
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-M-o") 'find-file-literally-at-point)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c i") 'indent-buffer)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "<M-return>") 'find-file-at-point)
(global-set-key (kbd "C-l") 'my/menu-base)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key (kbd "C-S-k") 'my/kill-buffer-close-window)
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "C-S-o") 'project-find-file)
(global-set-key (kbd "M-;") 'my/comment-uncomment-line)
(global-set-key (kbd "C-S-v") 'my/xah-select-line)
(global-set-key (kbd "C-,") 'consult-global-mark)
(global-set-key (kbd "C-c 1") 'consult-flymake)
(global-set-key (kbd "C-c 2") 'flymake-show-diagnostics-buffer)
(define-key project-prefix-map (kbd "C-c C-c") 'project-compile)
(add-hook 'magit-status-mode-hook (lambda ()
																		(define-key magit-status-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-status-mode-map [mouse-1] 'magit-section-cycle)
                                    (define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-log-mode-map [mouse-1] 'magit-show-commit)
                                    (define-key magit-revision-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-revision-mode-map [mouse-1] 'magit-section-cycle)
                                    (define-key magit-stash-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-stash-mode-map [mouse-1] 'magit-section-cycle)
                                    (define-key magit-process-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-process-mode-map [mouse-1] 'magit-section-cycle)
                                    (define-key magit-diff-mode-map (kbd "<C-tab>") 'other-window)
                                    (define-key magit-diff-mode-map [mouse-1] 'magit-section-cycle)))
(add-hook 'org-mode-hook (lambda ()
													 (define-key org-mode-map (kbd "<C-tab>") 'other-window)))
(define-key minibuffer-local-map (kbd "C-S-i") 'insert-register)
(global-set-key (kbd "C-`") 'push-mark-no-activate)
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)
(global-unset-key [mode-line mouse-3])
(global-unset-key [mode-line mouse-2])
(global-unset-key [mode-line mouse-1])

(define-key mode-line-buffer-identification-keymap
	[mode-line mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'consult-buffer)))

(define-key mode-line-buffer-identification-keymap
	[mode-line-buffer-identification mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'consult-buffer)))

(define-key global-map
	[mode-line mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'my/menu-base)))
(define-key global-map
	[mode-line mouse-3]
	(lambda ()
		(interactive)
		(call-interactively 'delete-window)))

;; (define-key minibuffer-local-map [mouse-wheel-down-event] (lambda ()
;; 																														(message "down")))

(define-key minibuffer-local-map [mouse-3] 'keyboard-escape-quit)

(define-key mode-line-buffer-identification-keymap
	[mode-line mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'consult-buffer)))

(define-key mode-line-buffer-identification-keymap
	[mode-line-buffer-identification mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'consult-buffer)))

(define-key global-map
	[mode-line mouse-1]
	(lambda ()
		(interactive)
		(call-interactively 'my/menu-base)))
(define-key global-map
	[mode-line mouse-3]
	(lambda ()
		(interactive)
		(call-interactively 'delete-window)))

(define-key minibuffer-local-map [mouse-3] 'keyboard-escape-quit)

;; for touchpad
(define-key minibuffer-local-map [mouse-4] 'next-line)
(define-key minibuffer-local-map [mouse-5] 'previous-line)
;; for mouse
(define-key minibuffer-local-map [wheel-down] 'next-line)
(define-key minibuffer-local-map [wheel-up] 'previous-line)

(provide 'my-keys)
