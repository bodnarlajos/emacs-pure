;; -*- lexical-binding: t -*-

(defvar my/side-bottom-window-height-threshold 20 "It means how many lines mean it is a big size")
(defvar my/side-bottom-window-height 10 "This value and the minimal height will be the height to the bottom side window")
(defvar my/mainframe (selected-frame))

;; It's a technical variable, don't modify it
(defvar my/mainwindow (car (window-list)))

(defun my/find-side-window-bottom ()
	"Find the bottom side window"
	(let ((wins (window-list))
				(resultwin nil))
		(while wins
			;; (message "%s" (car wins))
			(let ((winslot (window-parameter (car wins) 'window-slot))
						(winside (window-parameter (car wins) 'window-side)))
				(if (and winslot (equal winside 'bottom))
						(progn
							(setq resultwin (car wins))
							(setq wins nil))
					(setq wins (cdr wins)))))
		resultwin))

(defun my/enlarge-side-window ()
	"Enlarge side window"
	(let ((sidewin (my/find-side-window-bottom))
				(currwin (car (window-list))))
		(when sidewin
			(select-window sidewin)
			(enlarge-window 1000)
			(select-window currwin))))
(defun my/shrink-side-window ()
	"Shrink side window"
	(let ((sidewin (my/find-side-window-bottom))
				(currwin (car (window-list))))
		(when sidewin
			(select-window sidewin)
			(shrink-window 1000)
			(enlarge-window my/side-bottom-window-height)
			(select-window currwin))))

(defun my/toggle-size-side-window-bottom ()
	"Toggle bottom side window size"
	(interactive)
	(let ((bottomSideWindow (my/find-side-window-bottom)))
		(when bottomSideWindow
			(if (< my/side-bottom-window-height-threshold (window-total-height bottomSideWindow))
					(my/shrink-side-window)
				(my/enlarge-side-window)))))

(defun my/display-buffer-bottom (buffer alist)
	"Display buffer in where i want it"
	;; (message "my/display-buffer")
	(display-buffer-reuse-window buffer alist))

(defun my/display-buffer-magit (buffer alist)
	"Display buffer in where i want it"
	;; (message "my/display-buffer")
	(let ((commitBufferWin (or (get-buffer-window "COMMIT_EDITMSG") (get-buffer-window "MERGE_MSG")))
				(currWin (selected-window)))
		(if (member  (buffer-name buffer) '("COMMIT_EDITMSG" "MERGE_MSG"))
				(display-buffer-pop-up-window buffer alist)
			(if (equal commitBufferWin currWin)
					(set-window-buffer my/mainwindow buffer)
				(display-buffer-reuse-window buffer alist))))
	);; my/display-buffer-magit

(defun my/open-it-in-main (buffer alist)
	"open buffer in main window"
	(let ((curr-window (selected-window))
				(curr-frame (selected-frame)))
		;; (message "%s" (window-list))
		;; (message "curr-frame: %s, main-frame: %s" curr-frame my/mainframe)
		(let ((isSideWindow (window-parameter curr-window 'window-slot)))
			;; (message "open it in main window, bufferName: %s" (buffer-name buffer))
			(if (equal curr-frame my/mainframe) ;; if main frame is the selected-frame
					(if (and (not (equal curr-window my/mainwindow)) (not isSideWindow))
							(set-window-buffer curr-window buffer)
						(set-window-buffer my/mainwindow buffer))
				(progn
					(message "other frame"))))))

(setq switch-to-buffer-preserve-window-point nil)
(setq switch-to-buffer-obey-display-actions t)

(setq display-buffer-alist
      `(;; no window
        ("\\*\\(Async Shell.*\\)\\*"
         (display-buffer-reuse-window my/display-buffer-bottom display-buffer-no-window))
				;; go to the bottom window
        ("\\*\\(Backtrace\\|rg\\|Warnings\\|Compile-Log\\|Flycheck errors\\|Messages\\|Help\\|eshell\\|shell\\|Async-native-compile-log\\|Ediff Registry\\|Find\\)\\*"
         (display-buffer-reuse-window my/display-buffer-bottom display-buffer-in-side-window)
         (window-height . 0.33)
         (side . bottom)
         (slot . 0))
				;; it'll behave like normaly
				("\\*transient\\*\\|\\*Deletions\\*"
				 (display-buffer-reuse-window display-buffer-use-some-window display-buffer-same-window))
				("magit-diff:.*\\|COMMIT_EDITMSG" my/display-buffer-magit)
				;; the other windows go to the main window
				(".*"
				 (display-buffer-reuse-window my/open-it-in-main))))

(provide 'my-layout)
