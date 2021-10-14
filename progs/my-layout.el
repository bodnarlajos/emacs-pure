;; -*- lexical-binding: t -*-

(defvar my/mainbuffer (car (window-list)))
(defun my/display-buffer-bottom (buffer alist)
	"Display buffer in where i want it"
	(message "my/display-buffer")
	(display-buffer-reuse-window buffer alist))

(defun my/open-it-in-main (buffer alist)
	"open buffer in main window"
	(message "open it in main window")
	(set-window-buffer my/mainbuffer buffer))

(setq display-buffer-alist
      `(;; no window
        ("\\*\\(Async Shell.*\\)\\*"
         (display-buffer-reuse-window my/display-buffer-bottom display-buffer-no-window))
        ("\\*\\(Backtrace\\|rg\\|Warnings\\|Compile-Log\\|Flycheck errors\\|Messages\\|Help\\|eshell\\)\\*"
         (display-buffer-reuse-window my/display-buffer-bottom display-buffer-in-side-window)
         (window-height . 0.33)
         (side . bottom)
         (slot . 0)
				 (window-parameters (mode-line-format . none)))
				(".*"
				 (display-buffer-reuse-window my/open-it-in-main))))

(push (cons "^magit-log: " display-buffer--other-frame-action) display-buffer-alist)
(push (cons ".~.*~$" display-buffer--other-frame-action) display-buffer-alist)
(setq switch-to-buffer-preserve-window-point nil)
(setq switch-to-buffer-obey-display-actions t)

(provide 'my-layout)
