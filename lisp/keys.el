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
(global-set-key (kbd "M-o") 'my/open-file)
(global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "S-RET") 'crux-smart-open-line)
(global-set-key (kbd "C-<return>") 'crux-smart-open-line-above)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

(with-eval-after-load 'org
  (define-key org-mode-map [mouse-1] 'org-cycle)

  (define-key org-mode-map (kbd "S-<return>") 'my/org-new-line)
  (define-key org-mode-map (kbd "M-RET") 'consult-buffer))

(with-eval-after-load 'term
  (define-key term-mode-map (kbd "M-<return>") 'consult-buffer)
  (define-key term-raw-map (kbd "M-<return>") 'consult-buffer))

(with-eval-after-load 'shell
  (define-key shell-mode-map (kbd "M-<return>") 'consult-buffer))

(with-eval-after-load 'markdown-mode
  (message "markdown loaded")
  (define-key markdown-mode-map (kbd "M-<return>") 'consult-buffer))

;; consult
(with-eval-after-load 'consult
  (global-set-key (kbd "M-RET") 'consult-buffer)
  (global-set-key (kbd "M-s s") 'consult-ripgrep-symbol-at-point)
  (global-set-key (kbd "M-s g") 'consult-ripgrep)
  (global-set-key (kbd "M-s S-n") 'consult-ripgrep-search-in-notes)
  (global-set-key (kbd "M-s M-n") 'consult-ripgrep-search-in-temp-dir)
  (global-set-key (kbd "M-s M-g") 'consult-git-grep)
  (global-set-key (kbd "M-s M-s") 'consult-ripgrep-related-files))

(global-set-key [remap kill-ring-save] 'easy-kill)

(provide 'keys)
