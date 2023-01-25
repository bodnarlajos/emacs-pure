;; -*- lexical-binding: t -*-

(cua-mode +1)

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
(global-set-key (kbd "C-M-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "S-<return>") 'crux-smart-open-line)
(global-set-key (kbd "C-<return>") 'crux-smart-open-line-above)
(define-key cua-global-keymap (kbd "C-<return>") 'crux-smart-open-line-above)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(global-set-key (kbd "C-s") 'save-buffer)
(windmove-default-keybindings  '(meta shift))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "S-<return>") 'dired-find-file-other-window))

(with-eval-after-load 'csharp-mode
  (define-key csharp-mode-map (kbd "<tab>") 'completion-at-point))

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
  (define-key markdown-mode-map (kbd "M-<return>") 'consult-buffer))

(with-eval-after-load 'diff-mode
  (define-key diff-mode-map (kbd "M-<return>") 'consult-buffer)
  (define-key diff-mode-map (kbd "M-o") 'my/open-file))

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "M-RET") #'vertico-next))

;; consult
(with-eval-after-load 'consult
  (global-set-key (kbd "M-RET") 'consult-buffer)
  (global-set-key (kbd "M-s s") 'consult-ripgrep-symbol-at-point)
  (global-set-key (kbd "M-s g") 'consult-ripgrep)
  (global-set-key (kbd "M-s S-n") 'consult-ripgrep-search-in-notes)
  (global-set-key (kbd "M-s M-n") 'consult-ripgrep-search-in-temp-dir)
  (global-set-key (kbd "M-s M-g") 'consult-git-grep)
  (global-set-key (kbd "M-s l") 'consult-line)
  (global-set-key (kbd "M-s M-s") 'consult-ripgrep-related-files))

(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(with-eval-after-load 'eww
  (define-key eww-mode-map (kbd "M-t") 'gts-do-translate)
  (define-key eww-mode-map (kbd "M-<return>") 'consult-buffer)
  (define-key eww-mode-map (kbd "M-RET") 'consult-buffer))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory))

(define-prefix-command 'my-keys)
(global-set-key (kbd "M-l") 'my-keys)

(define-key my-keys (kbd "d") 'duplicate-line)
(define-key my-keys (kbd "[") 'backward-paragraph)
(define-key my-keys (kbd "]") 'forward-paragraph)
(define-key my-keys (kbd "o") 'other-window)
(define-key my-keys (kbd "M-o") 'my/open-file)
(define-key my-keys (kbd "M-RET") 'consult-buffer)
(define-key my-keys (kbd "-") 'split-window-vertically)
(define-key my-keys (kbd "|") 'split-window-horizontally)
(define-key my-keys (kbd "X") 'delete-other-windows)
(define-key my-keys (kbd "e") 'my/eval-region)
(define-key my-keys (kbd "x") 'delete-window)
(define-key my-keys (kbd "i") 'ibuffer)
(define-key my-keys (kbd "K") 'my/kill-buffer)
(define-key my-keys (kbd "r") 'cua-toggle-rectangle-mark)
(define-key my-keys (kbd ";") 'winner-undo)
(define-key my-keys (kbd "s") 'hydra-smerge/body)
(which-key-add-key-based-replacements "M-l s" "Smerge")
(define-key my-keys (kbd ":") 'winner-redo)
(define-key my-keys (kbd "<tab>") 'next-buffer)
(define-key my-keys (kbd "l") 'my-lsp-keys)
(define-key my-keys (kbd "j") 'consult-register)
(define-key my-keys (kbd "b") 'consult-global-mark)
(define-key my-keys (kbd "B") 'consult-mark)
(define-key my-keys (kbd "M-z") 'my/toggle-word-wrap)
(define-key my-keys (kbd "/") 'indent-buffer)

(define-prefix-command 'my-lsp-keys)
(define-key my-lsp-keys (kbd "c") 'compile)
(define-key my-lsp-keys (kbd "r") 'dap-debug)
(define-key my-lsp-keys (kbd "l") 'lsp)

(repeat-mode)
(repeatize 'my-keys)

(provide 'keys)
