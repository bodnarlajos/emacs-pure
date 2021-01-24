(straight-use-package 'ivy)
(straight-use-package 'smex)
(straight-use-package 'counsel)
(straight-use-package 'counsel-fd)
(straight-use-package 'ivy-rich)

(setq-default ivy-use-virtual-buffers nil
							ivy-virtual-abbreviate 'fullpath
							ivy-count-format ""
							ivy-magic-tilde nil
							ivy-dynamic-exhibit-delay-ms 1000
							ivy-use-selectable-prompt t)

(ivy-mode)
(ivy-rich-mode 1)

;; IDO-style directory navigation
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
(dolist (k '("C-j" "C-RET"))
  (define-key ivy-minibuffer-map (kbd k) #'ivy-immediate-done))

(define-key ivy-minibuffer-map (kbd "<up>") #'ivy-previous-line-or-history)
(define-key ivy-minibuffer-map (kbd "<down>") #'ivy-next-line-or-history)
(define-key ivy-minibuffer-map (kbd "C-w") 'ivy-yank-word)

(define-key ivy-occur-mode-map (kbd "C-c C-q") #'ivy-wgrep-change-to-wgrep-mode)
(define-key ivy-minibuffer-map [tab] 'ivy-next-line)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-f") 'swiper)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-b") 'counsel-switch-buffer)
(global-set-key (kbd "C-M-f") 'counsel-fd-file-jump)
(global-set-key (kbd "C-M-d") 'counsel-fd-dired-jump)

(my/installed "ivy")

