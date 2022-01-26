;;; frontside-windowing.el --- Consistent windowing and window splitting experience -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; SPDX-License-Identifier: MIT

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1") )
;; Keywords: files, tools
;; URL: https://github.com/frontside/frontmacs/packages/windowing

;;; Commentary:

;; Make window navigation consistent and intuitive.

;; 1. It's annoying when you're using a lot of multi-window flows and commands
;; that render their output in a separate window are constantly either
;; splitting horizontally, or sometimes they open above, or sometimes they
;; open three or four splits at a time.  Instead, you want the same
;; splitting behavior for the same UI workflow no matter what the
;; screen size.

;; This makes the split super simple and thereby consisent by always
;; splitting horizontally by half.

;; 2. Add keybindings so that window navigation works similar to tabbed navigation
;; 3. Aesthetic fixes such as removing double-rendered scroll bars

;;; Code:

(define-minor-mode frontside-windowing-mode
  "Make window splits dead simple and consistent"
  :keymap (let ((keymap (make-sparse-keymap)))
         (define-key keymap [remap split-window-below] #'frontside-windowing--vsplit-last-buffer)
         (define-key keymap [remap split-window-right] #'frontside-windowing--hsplit-last-buffer)
         keymap)
	(my/set-side-windows)
  (if frontside-windowing-mode
      (frontside-windowing-on)
    (frontside-windowing-off)))

;;;###autoload
(define-globalized-minor-mode frontside-windowing frontside-windowing-mode
  (lambda () (frontside-windowing-mode +1)))

(defvar-local frontside-windowing-original-split-height-threshold
  split-height-threshold
  "A place to hold the original value of split-height-threshold in a buffer.
This way, it can be reverted if for any reason this windowing mode is disabled")

(defvar my/side-bottom-window-height-threshold 20 "It means how many lines mean it is a big size")
(defvar my/side-bottom-window-height 10 "This value and the minimal height will be the height to the bottom side window")
(defun my/toggle-size-side-window-bottom ()
	"Toggle bottom side window size"
	(interactive)
	(let ((bottomSideWindow (my/find-side-window-bottom)))
		(when bottomSideWindow
			(if (< my/side-bottom-window-height-threshold (window-total-height bottomSideWindow))
					(my/shrink-side-window)
				(my/enlarge-side-window)))))
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

(defun my/set-side-windows ()
	"T."
	(setq display-buffer-alist
      `(("\\*undo-tree\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (window-height . 0.20)
         (side . left)
         (slot . 5))
				("\\*\\(transient\\|Deletions\\|Messages\\|Completions\\|eshell\\)\\*"
				 (display-buffer-reuse-window display-buffer-in-side-window)
         (window-height . 0.20)
         (side . bottom)
         (slot . 1)))))

(defun frontside-windowing-off()
  "reset everything to its original state"
  (setq split-height-threshold
        frontside-windowing-original-split-height-threshold)
  (remove-hook 'window-configuration-change-hook
               #'frontside-windowing--window-configuration-change-hook))

(defun frontside-windowing-on()
  "Make working with windows consistent."

  ;; Split horizontally when opening a new window from a command
  ;; whenever possible.
  (setq frontside-windowing-original-split-height-threshold
        split-height-threshold)
  (set (make-local-variable 'split-height-threshold) nil)

  ;; recaculate split-width-threshold with every change
  (add-hook 'window-configuration-change-hook
            #'frontside-windowing--window-configuration-change-hook))

(defun frontside-windowing--window-configuration-change-hook ()
  "Set the `split-width-threshold' so that the screen only splits once.

For example, if the frame is 360 columns wide, then we want the
`split-width-threshold' to be 181. That way, when you split
horizontally, the two new windows will each be 180 columns wide, and
sit just below the threshold."
  (setq split-width-threshold (- (frame-width) (/ (frame-width) 5))))

(defun frontside-windowing--vsplit-last-buffer ()
  "Vertically split the screen, and open the next buffer in the new window."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))


(defun frontside-windowing--hsplit-last-buffer ()
  "Horizonally split the screen, and open the next buffer in the new window."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

(provide 'frontside-windowing)
;;; frontside-windowing.el ends here
