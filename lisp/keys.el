;; -*- lexical-binding: t -*-

(straight-use-package 'general)

;; keys
(global-set-key (kbd "C-/") 'cape-dabbrev)
(global-set-key (kbd "C-z") 'undo-only)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)
(global-set-key (kbd "M-RET") 'consult-buffer)
(global-set-key (kbd "M-o") 'my/open-file)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "S-RET") 'crux-smart-open-line)
(global-set-key (kbd "C-<return>") 'crux-smart-open-line-above)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

(provide 'keys)
