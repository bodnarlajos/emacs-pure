;; -*- lexical-binding: t -*-

(straight-use-package 'project)
(straight-use-package 'which-key)

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)
(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-f") 'isearch-forward)
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
(global-set-key (kbd "M-m") 'my-prefix)
(define-key my-prefix (kbd "(") 'kmacro-start-macro)
(define-key my-prefix (kbd ")") 'kmacro-end-macro)
(define-key my-prefix (kbd ">") 'kmacro-call-macro)
(define-key my-prefix (kbd "<SPC>") 'back-button-push-mark-local-and-global)
(define-key my-prefix (kbd "d") 'duplicate-line)

(define-key my-prefix (kbd "x") 'execute-extended-command)

(define-key my-prefix (kbd "g h") 'windmove-left)
(define-key my-prefix (kbd "g l") 'windmove-right)
(define-key my-prefix (kbd "g j") 'windmove-up)
(define-key my-prefix (kbd "g k") 'windmove-down)
(which-key-add-key-based-replacements "M-m g" "Move window")

(define-key my-prefix (kbd "k h") 'windmove-delete-left)
(define-key my-prefix (kbd "k l") 'windmove-delete-right)
(define-key my-prefix (kbd "k j") 'windmove-delete-up)
(define-key my-prefix (kbd "k k") 'windmove-delete-down)
(which-key-add-key-based-replacements "M-m k" "Delete window")

(define-key my-prefix (kbd "w |") 'split-window-vertically)
(define-key my-prefix (kbd "w -") 'split-window-horizontally)
(define-key my-prefix (kbd "w h") 'windmove-swap-states-left)
(define-key my-prefix (kbd "w l") 'windmove-swap-states-right)
(define-key my-prefix (kbd "w j") 'windmove-swap-states-up)
(define-key my-prefix (kbd "w k") 'windmove-swap-states-down)
(which-key-add-key-based-replacements "M-m w" "Split window")

(define-key my-prefix (kbd "r") 'async-shell-command)
(define-key my-prefix (kbd "i") 'indent-buffer)

;; frames
(define-key my-prefix (kbd "f k") 'delete-frame)
(define-key my-prefix (kbd "f c") 'make-frame)
(define-key my-prefix (kbd "f r") 'my/make-frame-readonly)
(which-key-add-key-based-replacements "M-m f" "Frame functions")

(define-key my-prefix (kbd "s l") 'my/xah-select-line)
(define-key my-prefix (kbd "s c") 'my/copy-line)
(which-key-add-key-based-replacements "M-m s" "Select functions")

(define-key my-prefix (kbd "2") 'flycheck-list-errors)
(define-key my-prefix (kbd "t") 'transpose-frame)
(define-key my-prefix (kbd "b") 'consult-buffer)
(define-key my-prefix (kbd "c g") 'my/goto-magit)
(define-key my-prefix (kbd "c p") 'project-find-file)
(define-key my-prefix (kbd "c f") 'rg)
(define-key my-prefix (kbd "c m") 'my/menu-base)
(define-key my-prefix (kbd "c a") 'org-agenda)
(which-key-add-key-based-replacements "M-m c" "Commands")

(define-key my-prefix (kbd "e d") 'duplicate-line)
(define-key my-prefix (kbd "e r") 'vr/replace)
(define-key my-prefix (kbd "e a") 'my/select-all)
(define-key my-prefix (kbd "e c") 'consult-register-store)
(define-key my-prefix (kbd "e r") 'consult-register-load)
(define-key my-prefix (kbd "e f") 'isearch-forward)
(which-key-add-key-based-replacements "M-m e" "Edit functions")

(define-key my-prefix (kbd "p f") 'cape-file)
(define-key my-prefix (kbd "p d") 'cape-dabbrev)
(define-key my-prefix (kbd "p l") 'cape-line)
(define-key my-prefix (kbd "p s") 'cape-symbol)
(define-key my-prefix (kbd "p k") 'cape-keyword)
(which-key-add-key-based-replacements "M-m p" "Complete functions")

(define-key my-prefix (kbd "M-[") 'hs-show-all)
(define-key my-prefix (kbd "M-]") 'hs-hide-all)
(define-key my-prefix (kbd "]") 'hs-toggle-hiding)

(define-key my-prefix (kbd "o") 'find-file)
(define-key my-prefix (kbd "S-o") 'project-find-file)

(global-set-key (kbd "C-S-p") 'my/menu-base)

(global-set-key (kbd "<f1>") 'window-toggle-side-windows)
(global-set-key (kbd "<S-f1>") 'my/toggle-size-side-window-bottom)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-S-k") 'my/kill-buffer-close-window)
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

(provide 'my-keys)
