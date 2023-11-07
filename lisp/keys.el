;; -*- lexical-binding: t -*-
(cua-mode +1)
(with-eval-after-load 'cua
  (message "cua-mode keymap")
  (define-key 'cua-global-keymap (kbd "C-<return>") 'crux-smart-open-line)
  (define-key 'cua-global-keymap (kbd "M-<return>") 'cua-set-rectangle-mark))

;; keys
(global-set-key (kbd "C-/") 'cape-dabbrev)
(global-set-key (kbd "C-z") 'undo-only)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)
(global-set-key (kbd "M-o") '/open-file)
(global-set-key (kbd "C-M-a") 'crux-move-beginning-of-line)
(global-set-key (kbd "C-a") 'my/select-all)
(global-set-key (kbd "M-0") 'delete-other-windows)
(global-set-key (kbd "C-k") 'crux-smart-kill-line)
(global-set-key (kbd "M-S-<return>") 'crux-smart-open-line-above)
(global-set-key (kbd "M-<return>") 'crux-smart-open-line)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C-S-f") 'isearch-forward)
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "M-q") 'delete-other-windows)
(windmove-default-keybindings  '(meta))
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "C-S-n") 'my/new-empty-buffer)
(global-set-key (kbd "C-S-o") 'my/new-empty-org-buffer)
(global-set-key (kbd "C-b") '/switch-buffer)
(define-key minibuffer-local-map (kbd "C-b") 'next-line)
(global-set-key (kbd "M-S-k") 'my/kill-buffer)
(global-set-key (kbd "M--") 'delete-window)
(global-set-key (kbd "<BLAH-m>") '/show-menu)
(global-set-key (kbd "<BLAH-i>") project-prefix-map)
(global-set-key (kbd "<BLAH-lsb>") 'my/kill-buffer)
(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)
(global-set-key (kbd "C-<next>") 'forward-sexp)
(global-set-key (kbd "C-<prior>") 'backward-sexp)
(global-set-key (kbd "M-<next>") 'mark-sexp)
(global-set-key (kbd "C-M-<next>") 'up-list)
(global-set-key (kbd "C-M-<prior>") 'backward-up-list)

(with-eval-after-load 'easy-kill
  (global-set-key [remap kill-ring-save] 'easy-kill))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "?") 'dired-get-size)
  (define-key dired-mode-map (kbd "S-<return>") 'dired-find-file-other-window))

(with-eval-after-load 'csharp-mode
  (define-key csharp-mode-map (kbd "<tab>") 'completion-at-point))

(with-eval-after-load 'org
  (define-key org-mode-map [mouse-1] 'org-cycle)
  (define-key org-mode-map (kbd "C-r") 'org-babel-execute-src-block)

  (define-key org-mode-map (kbd "S-<return>") 'my/org-new-line)
  (define-key org-mode-map (kbd "C-b") '/switch-buffer))

(with-eval-after-load 'term
  (define-key term-mode-map (kbd "C-b") '/switch-buffer)
  (define-key term-raw-map (kbd "C-b") '/switch-buffer))

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-b") '/switch-buffer))

(with-eval-after-load 'diff-mode
  (define-key diff-mode-map (kbd "C-b") '/switch-buffer)
  (define-key diff-mode-map (kbd "M-o") 'my/open-file))

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-b") #'vertico-next))

;; consult
(with-eval-after-load 'consult
  (global-set-key (kbd "C-b") '/switch-buffer)
  (global-set-key (kbd "C-x b") 'consult-buffer)
  (global-set-key (kbd "M-s s") 'consult-ripgrep-symbol-at-point)
  (global-set-key (kbd "M-s g") 'consult-ripgrep)
  (global-set-key (kbd "M-s M-n") 'consult-ripgrep-search-in-notes)
  (global-set-key (kbd "M-s M-g") 'consult-git-grep)
  (global-set-key (kbd "M-s l") 'consult-line)
  (global-set-key (kbd "M-s M-s") 'consult-ripgrep-related-files))

(with-eval-after-load 'lsp
  (global-set-key (kbd "M-s l") 'lsp-find-references)
  (global-set-key (kbd "M-s m") 'lsp-find-implementation)
  (global-set-key (kbd "M-s t") 'lsp-find-type-definition)
  (global-set-key (kbd "M-s t") 'lsp-find-type-definition)
  (global-set-key (kbd "M-s c") 'lsp-execute-code-action)
  (global-set-key (kbd "C-.") 'lsp-execute-code-action))

(with-eval-after-load 'dap
  (global-set-key (kbd "M-s b") 'dap-breakpoint-toggle))

(with-eval-after-load 'eww
  (define-key eww-mode-map (kbd "M-t") 'gts-do-translate)
  (define-key eww-mode-map (kbd "C-b") '/switch-buffer)
  (define-key eww-mode-map (kbd "C-b") '/switch-buffer))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory))

(define-prefix-command 'my-keys)
(global-set-key (kbd "M-l") 'my-keys)

(define-key my-keys (kbd "d") 'duplicate-line)
(define-key my-keys (kbd "e") 'my/eval-region)
(define-key my-keys (kbd "i") 'ibuffer)
(define-key my-keys (kbd "t") 'gts-do-translate)
(define-key my-keys (kbd ";") 'winner-undo)
(define-key my-keys (kbd "s") 'hydra-smerge/body)
(define-key my-keys (kbd ":") 'winner-redo)
(define-key my-keys (kbd "l") 'my-lsp-keys)
(define-key my-keys (kbd "j") 'consult-register)
(define-key my-keys (kbd "b") 'consult-global-mark)
(define-key my-keys (kbd "B") 'consult-mark)
(define-key my-keys (kbd "M-z") 'my/toggle-word-wrap)
(define-key my-keys (kbd "/") 'indent-buffer)
(define-key my-keys (kbd "p f") 'my/print-file-name)
(define-key my-keys (kbd "p b") 'my/print-buffer-name)
(define-key my-keys (kbd "p i") '/start-ide)
(define-key my-keys (kbd "p n") '/open-notes)
(define-key my-keys (kbd "p g") 'magit-status)

(which-key-add-key-based-replacements "M-l s" "Smerge"
  "M-l p" "Programs"
  "M-l p f" "Print filename"
  "M-l p b" "Print buffername"
  "M-l p i" "Ide mode"
  "M-l p n" "Open note"
  "M-l p g" "Open git client"
  "M-l l" "LSP functions")

(define-prefix-command 'my-lsp-keys)
(define-key my-lsp-keys (kbd "c") 'compile)
(define-key my-lsp-keys (kbd "r") 'dap-debug)
(define-key my-lsp-keys (kbd "l") 'lsp)

(repeat-mode)
(repeatize 'my-keys)

(provide 'keys)
