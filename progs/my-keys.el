;; -*- lexical-binding: t -*-

(straight-use-package 'project)
(straight-use-package 'which-key)

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

(global-set-key (kbd "<C-escape>") 'my/start/menu)
(global-set-key (kbd "<C-f1>") 'my/start/menu)

(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-f") 'ctrlf-forward-fuzzy-regexp)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)

(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)

(with-eval-after-load 'dabbrev
  (global-set-key (kbd "C-M-S-/") 'dabbrev-completion)
  (global-set-key (kbd "C-M-/") 'dabbrev-expand))
(global-set-key (kbd "M-/") 'completion-at-point)

(with-eval-after-load 'corfu
  (define-key corfu-map (kbd "TAB") 'corfu-next)
  (define-key corfu-map [tab] 'corfu-next)
  (define-key corfu-map [backtab] 'corfu-previous)
  (define-key corfu-map (kbd "S-TAB") 'corfu-previous)
  (define-key corfu-map (kbd "M-/") 'corfu-next)
  )

(define-prefix-command 'my-prefix)
(global-set-key (kbd "M-j") 'my-prefix)
(define-key my-prefix (kbd "(") 'kmacro-start-macro)
(define-key my-prefix (kbd ")") 'kmacro-end-macro)
(define-key my-prefix (kbd ">") 'kmacro-call-macro)
(define-key my-prefix (kbd "<SPC>") 'back-button-push-mark-local-and-global)
(define-key my-prefix (kbd "d") 'duplicate-line)

(defun my/run/shell-command ()
	"Run a shell command"
	(interactive)
	(setq-local shell-command-switch "-ic")
	(call-interactively 'async-shell-command))

(define-key my-prefix (kbd "a") 'my/run/shell-command)
(define-key my-prefix (kbd "A") 'project-async-shell-command)
(define-key my-prefix (kbd "i") 'indent-buffer)

(define-key my-prefix (kbd "s l") 'my/xah-select-line)
(define-key my-prefix (kbd "s c") 'my/copy-line)
(which-key-add-key-based-replacements "M-j s" "Select functions")

(define-key my-prefix (kbd "2") 'flycheck-list-errors)
(define-key my-prefix (kbd "T") 'transpose-frame)

(define-key my-prefix (kbd "M-[") 'my/show-all)
(define-key my-prefix (kbd "M-]") 'my/hide-all)
(define-key my-prefix (kbd "]") 'my/hide-entry)
(define-key my-prefix (kbd "[") 'my/show-entry)

(define-key my-prefix (kbd "M-j") 'execute-extended-command)

(define-key my-prefix (kbd "o") 'find-file)
(define-key my-prefix (kbd "S-o") 'project-find-file)

(global-set-key (kbd "M-RET") 'my/start/menu)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-S-o") 'project-find-file)
(global-set-key (kbd "M-;") 'my/comment-uncomment-line)
(define-key project-prefix-map (kbd "C-c C-c") 'project-compile)

;; menu 
(defvar right-popup-menu 
  (let ((menu (make-sparse-keymap "Commands"))) 
    (define-key menu [undo] (cons "Undo" 'undo)) 
    (define-key menu [redo] (cons "Redo" 'redo)) 
    (define-key menu [my/ffap] (cons "Open file at point" 'my/ffap)) 
    (define-key menu [save-buffer] (cons "Save buffer" 'save-buffer)) 
    (define-key menu [my/xah-new-empty-buffer] (cons "New buffer" 'my/xah-new-empty-buffer)) 
    (define-key menu [yank] (cons "Paste" 'yank)) 
    (define-key menu [copy-region-as-kill] (cons "Copy" 'copy-region-as-kill)) 
    menu)) 

(defun right-popup-command () 
  "Run the command selected fromright-popup-menu'."
  (interactive)
  (call-interactively (or (car (x-popup-menu t right-popup-menu)))))
(global-set-key [mouse-3] 'right-popup-command)

(global-unset-key (kbd "C-x C-b"))
(global-unset-key (kbd "C-x b"))
(global-unset-key (kbd "M-RET"))
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "<f1>") 'my/start/menu)
(global-set-key (kbd "<f3>") 'my/open/new-tab-with-file)
(global-set-key (kbd "<f4>") 'tab-bar-close-tab)
(global-set-key (kbd "<f2>") 'other-window)
(global-set-key (kbd "M-RET") 'consult-buffer)
(global-set-key (kbd "M-r") 'query-replace-regexp)
(global-set-key (kbd "<C-M-left>") 'rotate-frame)
(global-set-key (kbd "<M-S-left>") 'windmove-swap-states-left)
(global-set-key (kbd "<M-right>") 'other-window)
(global-set-key (kbd "<M-S-right>") 'windmove-swap-states-right)
(global-set-key (kbd "C-.") 'repeat-complex-command)
(global-set-key (kbd "M-C-o") 'consult-recent-file)
(global-set-key (kbd "C-S-f") 'consult-line)
(global-set-key (kbd "M-s C-SPC") 'my/xah-select-line)
(global-set-key (kbd "C-M-.") 'repeat)
(global-unset-key (kbd "C-o"))
(global-unset-key (kbd "M-o"))
(global-set-key (kbd "C-o") 'project-find-file)
(global-set-key (kbd "M-o") 'project-find-file)
(global-unset-key (kbd "M-k"))
(define-prefix-command 'my-emacs-prefix)
(global-set-key (kbd "M-k") 'my-emacs-prefix)
(define-key 'my-emacs-prefix (kbd "k") 'kill-sentence)
(define-key 'my-emacs-prefix (kbd "p") 'kill-paragraph)
(define-key 'my-emacs-prefix (kbd "o") 'delete-other-windows)
(define-key 'my-emacs-prefix (kbd "l") 'kill-line)
(define-key 'my-emacs-prefix (kbd "w") 'delete-window)
(define-key 'my-emacs-prefix (kbd "b") 'kill-current-buffer)

(repeat-mode)
(repeatize 'my-prefix)
(repeatize 'my-emacs-prefix)

(provide 'my-keys)
