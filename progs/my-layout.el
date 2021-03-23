(require 'zoom)
(custom-set-variables
 ;; '(zoom-mode t)
 '(zoom-size '(0.8 . 0.8))
 '(zoom-ignored-buffer-names '("treemacs" "*xref*" "*undo-tree*"))
 '(zoom-ignored-buffer-name-regexps '("\\*.*imenu.*\\*" "\\*undo-tree\\*")))

(zoom-mode +1)

(defun count-visible-buffers (&optional frame)
  "Count how many buffers are currently being shown. Defaults to selected frame."
  (length (mapcar #'window-buffer (window-list frame))))

(defun do-not-split-more-than-two-windows (window &optional horizontal)
  (if (and horizontal (> (count-visible-buffers) 1))
      nil
    t))

;; (advice-add 'window-splittable-p :before-while #'do-not-split-more-than-two-windows)

(defun my/fix-imenu-size ()
  (with-selected-window (get-buffer-window "*lsp-ui-imenu*")
    (setq window-size-fixed t)
    (window-resize (selected-window) (- 30 (window-total-width)) t t)))

(add-hook 'imenu-list-update-hook 'my/fix-imenu-size)

(defvar my/window-no-other-no-delete
	'(window-parameters . ((no-other-window . t)
												 (no-delete-other-windows . t))))
(defvar my/window-no-delete
	'(window-parameters . ((no-delete-other-windows . t))))
(defun my/show-left-top (buffer alist)
  "T."
	(message "bname: %s" (buffer-name buffer))																 
	(let ((leftTopWin (frame-first-window)))
		(window--display-buffer buffer leftTopWin 'reuse)))
(defun my/largest-other-window (buffer alist)
  "T."
  (let ((sorted-windows (sort (window-list)
															(lambda (a b)
																(> (* (window-width a) (window-height a)) (* (window-width b) (window-height b))))))
				(firstLargeBuffer (car sorted-windows)))
		(catch '--cl-block-display-buffer-largest-other-window--
			(unless (or (equal sw (selected-window))
    							(window-minibuffer-p firstLargeBuffer))
				(window--display-buffer buffer firstLargeBuffer 'reuse)))))
(setq fit-window-to-buffer-horizontally t)
(setq window-resize-pixelwise t)
(setq switch-to-buffer-obey-display-actions t)
(setq
 display-buffer-alist
 `(("\\*\\(?:Ibuffer\\|.*imenu.*\\)\\*"
		display-buffer-in-side-window
		(side . right) (slot . -1) (window-width . 0.4) ;; (preserve-size . (700 . t))
		,my/window-no-delete)
	 ("\\*\\(?:undo-tree\\)\\*"
		display-buffer-in-side-window
		(side . left) (slot . -1) (window-width . fit-window-to-buffer) (preserve-size . (nil . t))
		,my/window-no-delete)
	 ("\\*\\(?:Minibuf-0\\|Minibuf-1\\)\\*"
		display-buffer-in-side-window
		(side . bottom) (window-height . 0.3) (slot . 1) (preserve-size . (nil . t))
		,my/window-no-delete)
	 ("\\*\\(?:Completions\\|IList\\)\\*"
		display-buffer-in-side-window
		(side . bottom) (slot . 1) (preserve-size . (nil . t))
		,my/window-no-other-no-delete)))

(provide 'my-layout)
