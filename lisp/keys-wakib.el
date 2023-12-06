(use-package wakib-keys
  :diminish wakib-keys
  :config
  (wakib-keys 1)
  (add-hook 'after-change-major-mode-hook 'wakib-update-major-mode-map)
  (add-hook 'menu-bar-update-hook 'wakib-update-minor-mode-maps)
  ;; Modifying other modules
  ;; When remap is used it exits isearch abruptly after first instance
  ;; Use explicit keybindings instead
  (define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-S-f") 'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "M-;") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "M-:") 'isearch-repeat-backward)
  (define-key isearch-mode-map (kbd "C-v") 'isearch-yank-kill)
  (define-key isearch-mode-map (kbd "M-d") 'isearch-delete-char)
  (global-set-key (kbd "M-o") 'project-find-file)
  (global-set-key (kbd "C-S-v") 'consult-yank-from-kill-ring))

(windmove-default-keybindings  '(meta))

(with-eval-after-load 'crux
  (global-set-key (kbd "<home>") 'crux-move-beginning-of-line))

(with-eval-after-load 'consult
  (global-set-key (kbd "C-b") 'consult-buffer)
  (global-set-key (kbd "M-b") 'consult-project-buffer))

(with-eval-after-load 'consult
  (global-set-key (kbd "C-b") 'consult-buffer)
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

(provide 'keys-wakib)
