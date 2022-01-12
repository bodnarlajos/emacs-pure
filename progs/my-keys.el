;; -*- lexical-binding: t -*-

(straight-use-package 'project)

(define-prefix-command 'my-prefix)

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)


(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)
(global-set-key (kbd "<M-C-left>") 'windmove-swap-states-left)
(global-set-key (kbd "<M-C-right>") 'windmove-swap-states-right)
(global-set-key (kbd "<M-C-up>") 'windmove-swap-states-up)
(global-set-key (kbd "<M-C-down>") 'windmove-swap-states-down)
(global-set-key (kbd "C-x C-z") #'selectrum-repeat)

(global-set-key (kbd "C-j") 'my-prefix)
(define-key my-prefix (kbd "m h") 'windmove-swap-states-left)
(define-key my-prefix (kbd "m l") 'windmove-swap-states-right)
(define-key my-prefix (kbd "m j") 'windmove-swap-states-up)
(define-key my-prefix (kbd "m k") 'windmove-swap-states-down)

(define-key my-prefix (kbd "g h") 'windmove-left)
(define-key my-prefix (kbd "g l") 'windmove-right)
(define-key my-prefix (kbd "g j") 'windmove-up)
(define-key my-prefix (kbd "g k") 'windmove-down)

(define-key my-prefix (kbd "k h") 'windmove-delete-left)
(define-key my-prefix (kbd "k l") 'windmove-delete-right)
(define-key my-prefix (kbd "k j") 'windmove-delete-up)
(define-key my-prefix (kbd "k k") 'windmove-delete-down)

(define-key my-prefix (kbd "w j") 'split-window-vertically)
(define-key my-prefix (kbd "w k") 'split-window-horizontally)

(define-key my-prefix (kbd "r") 'async-shell-command)
(define-key my-prefix (kbd "i") 'indent-buffer)
(define-key my-prefix (kbd "o") 'find-file)

;; frames
(define-key my-prefix (kbd "f k") 'delete-frame)
(define-key my-prefix (kbd "f c") 'make-frame)
(define-key my-prefix (kbd "f r") 'my/make-frame-readonly)

(define-key my-prefix (kbd "s l") 'my/xah-select-line)
(define-key my-prefix (kbd "s c") 'my/copy-line)
(define-key my-prefix (kbd "2") 'flycheck-list-errors)
(define-key my-prefix (kbd "t") 'transpose-frame)
(define-key my-prefix (kbd "b") 'consult-buffer)
(define-key my-prefix (kbd "b") 'consult-buffer)
(define-key my-prefix (kbd "c g") 'my/start/git)
(define-key my-prefix (kbd "c p") 'project-find-file)
(define-key my-prefix (kbd "c f") 'rg)
(define-key my-prefix (kbd "c m") 'my/menu-base)

(define-key my-prefix (kbd "e d") 'duplicate-line)
(define-key my-prefix (kbd "e r") 'vr/replace)
(define-key my-prefix (kbd "e a") 'my/select-all)
(define-key my-prefix (kbd "e c") 'consult-register-store)
(define-key my-prefix (kbd "e r") 'consult-register-load)
(define-key my-prefix (kbd "e f") 'isearch-forward)

(define-key my-prefix (kbd "C-j") 'my/menu-base)

(global-set-key (kbd "<f1>") 'window-toggle-side-windows)
(global-set-key (kbd "<S-f1>") 'my/toggle-size-side-window-bottom)

(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-f") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)

(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-S-c") 'my/copy-line)
(global-set-key (kbd "C-S-f") 'rg-dwim)
(global-set-key (kbd "<S-return>") 'crux-smart-open-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "C-M-o") 'find-file-literally-at-point)
(global-set-key (kbd "<M-return>") 'find-file-at-point)
(global-set-key (kbd "C-S-p") 'execute-extended-command)
(global-set-key (kbd "C-S-k") 'my/kill-buffer-close-window)
;; (global-set-key (kbd "<C-tab>") 'centaur-tabs-forward)
(global-set-key (kbd "<C-tab>") 'other-window)
;; (global-set-key (kbd "<C-S-tab>") 'centaur-tabs-backward)
(define-key minibuffer-local-map (kbd "<C-tab>") 'next-line)
(global-set-key (kbd "C-S-m") 'my/swap-window)
(global-set-key (kbd "C-S-o") 'project-find-file)
(global-set-key (kbd "M-;") 'my/comment-uncomment-line)
(global-set-key (kbd "C-,") 'consult-global-mark)
(define-key project-prefix-map (kbd "C-c C-c") 'project-compile)
(define-key minibuffer-local-map (kbd "C-S-i") 'insert-register)
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)

;; org mode map
(with-eval-after-load 'org
  (define-key org-mode-map [mouse-1] 'org-cycle)
	(add-hook 'org-mode-hook (lambda ()
													 (define-key org-mode-map (kbd "<C-tab>") 'my/select-window))))
;; menu 
(defvar right-popup-menu 
  (let ((menu (make-sparse-keymap "Commands"))) 
    (define-key menu [undo] (cons "Undo" 'undo)) 
    (define-key menu [redo] (cons "Redo" 'redo)) 
    (define-key menu [my/ffap] (cons "Open file at point" 'my/ffap)) 
    (define-key menu [rg-dwim] (cons "Search with rg" 'rg-dwim)) 
    (define-key menu [save-buffer] (cons "Save buffer" 'save-buffer)) 
    (define-key menu [mark-whole-buffer] (cons "Select all" 'my/select-all)) 
    (define-key menu [my/dumb-jump-go] (cons "Goto" 'my/dumb-jump-go))
		(define-key menu [xref-pop-marker-stack] (cons "Back to ..." 'xref-pop-marker-stack)) 
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
