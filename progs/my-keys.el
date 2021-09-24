(straight-use-package 'project)

(global-set-key (kbd "C-c h") 'windmove-swap-states-left)
(global-set-key (kbd "C-c k") 'windmove-swap-states-right)
(global-set-key (kbd "C-c u") 'windmove-swap-states-up)
(global-set-key (kbd "C-c j") 'windmove-swap-states-down)
(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-c C-r") 'copy-to-register)
(global-set-key (kbd "C-c C-v") 'consult-register)
(global-unset-key (kbd "C-c d"))
(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "C-S-c") 'my/copy-line)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "C-S-f") 'rg-dwim)
(global-set-key (kbd "C-c l") 'recenter)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-`") 'window-toggle-side-windows)
(global-set-key (kbd "C-M-o") 'find-file-literally-at-point)
(global-set-key (kbd "C-c i") 'indent-buffer)
(global-set-key (kbd "C-c o") 'find-file)
(global-set-key (kbd "<M-return>") 'find-file-at-point)
(global-set-key (kbd "C-l") 'my/menu-base)
(global-set-key (kbd "C-S-p") 'execute-extended-command)
(global-set-key (kbd "C-c b") 'purpose-switch-buffer-with-purpose)
(global-set-key (kbd "C-S-k") 'my/kill-buffer-close-window)
(global-set-key (kbd "<C-tab>") 'my/select-window)
(global-set-key (kbd "C-S-m") 'my/swap-window)
(global-set-key (kbd "C-c t") 'transpose-frame)
(global-set-key (kbd "C-S-o") 'project-find-file)
(global-set-key (kbd "M-;") 'my/comment-uncomment-line)
(global-set-key (kbd "C-c v") 'my/xah-select-line)
(global-set-key (kbd "C-,") 'consult-global-mark)
(global-set-key (kbd "C-c 2") 'flycheck-list-errors)
(define-key project-prefix-map (kbd "C-c C-c") 'project-compile)
(add-hook 'org-mode-hook (lambda ()
													 (define-key org-mode-map (kbd "<C-tab>") 'my/select-window)))
(define-key minibuffer-local-map (kbd "C-S-i") 'insert-register)
(global-set-key (kbd "C-`") 'push-mark-no-activate)
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)

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

(with-eval-after-load 'dired
	(define-key dired-mode-map (kbd "C-o") 'find-file))

;; for touchpad
(define-key minibuffer-local-map [mouse-4] 'next-line)
(define-key minibuffer-local-map [mouse-5] 'previous-line)
;; for mouse
(define-key minibuffer-local-map [wheel-down] 'next-line)
(define-key minibuffer-local-map [wheel-up] 'previous-line)

;; org mode map
(with-eval-after-load 'org
 (define-key org-mode-map [mouse-1] 'org-cycle)
 (define-key org-mode-map [mouse-3] 'org-shiftright)
 (defvar org-right-popup-menu
 (let ((menu (make-sparse-keymap "Org Commands")))
 (define-key menu [undo] (cons "Undo" 'undo))
 (define-key menu [redo] (cons "Redo" 'redo))
 (define-key menu [my/ffap] (cons "Open file at point" 'my/ffap)) 
 (define-key menu [rg-dwim] (cons "Search with rg" 'rg-dwim))
 (define-key menu [save-buffer] (cons "Save buffer" 'save-buffer))
 (define-key menu [mark-whole-buffer] (cons "Select all" 'mark-whole-buffer))
 (define-key menu [my/dumb-jump-go] (cons "Goto" 'my/dumb-jump-go)) 
 (define-key menu [yank] (cons "Paste" 'yank))
 (define-key menu [copy-region-as-kill] (cons "Copy" 'copy-region-as-kill))
 (define-key menu [my/xah-new-empty-buffer] (cons "New buffer" 'my/xah-new-empty-buffer))
 (define-key menu [org-shiftright] (cons "Todo..." 'org-shiftright))
 menu))
(defun org-right-popup-command ()
 "Run the command selected from right-popup-menu'." 
 (interactive) 
 (call-interactively (or (car (x-popup-menu t org-right-popup-menu))))) 
 (define-key org-mode-map [mouse-3] 'org-right-popup-command)) 
 
;; menu 
(defvar right-popup-menu 
 (let ((menu (make-sparse-keymap "Commands"))) 
 (define-key menu [undo] (cons "Undo" 'undo)) 
 (define-key menu [redo] (cons "Redo" 'redo)) 
 (define-key menu [my/ffap] (cons "Open file at point" 'my/ffap)) 
 (define-key menu [rg-dwim] (cons "Search with rg" 'rg-dwim)) 
 (define-key menu [save-buffer] (cons "Save buffer" 'save-buffer)) 
 (define-key menu [mark-whole-buffer] (cons "Select all" 'mark-whole-buffer)) 
 (define-key menu [my/dumb-jump-go] (cons "Goto" 'my/dumb-jump-go)) 
 (define-key menu [my/xah-new-empty-buffer] (cons "New buffer" 'my/xah-new-empty-buffer)) 
 (define-key menu [yank] (cons "Paste" 'yank)) 
 (define-key menu [copy-region-as-kill] (cons "Copy" 'copy-region-as-kill)) 
 menu)) 
 
(defun right-popup-command () 
 "Run the command selected fromright-popup-menu'."
 (interactive)
 (call-interactively (or (car (x-popup-menu t right-popup-menu)))))
(global-set-key [mouse-3] 'right-popup-command)

(provide 'my-keys)
