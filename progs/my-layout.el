;; -*- lexical-binding: t -*-

(defvar my/mainwindow (car (window-list)))
(defun my/display-buffer-bottom (buffer alist)
	"Display buffer in where i want it"
	(message "my/display-buffer")
	(display-buffer-reuse-window buffer alist))

(defun my/open-it-in-main (buffer alist)
	"open buffer in main window"
	(let ((curr-window (car (window-list))))
		(message "open it in main window, curr-window: %s, buffer: %s" curr-window (buffer-name buffer))
		(if (and (not (window-at-side-p curr-window)) (not (equal curr-window my/mainwindow)))
				(set-window-buffer curr-window buffer)
			(set-window-buffer my/mainwindow buffer))))

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
				("magit.*:.*\\|COMMIT_EDITMSG\\|\\*transient\\*\\|\\*Deletions\\*"
				 (display-buffer-reuse-window display-buffer-use-some-window display-buffer-same-window))
				(".*"
				 (display-buffer-reuse-window my/open-it-in-main))))

(push (cons "^magit-log: " display-buffer--other-frame-action) display-buffer-alist)
(push (cons ".~.*~$" display-buffer--other-frame-action) display-buffer-alist)
(setq switch-to-buffer-preserve-window-point nil)
(setq switch-to-buffer-obey-display-actions t)

(provide 'my-layout)
