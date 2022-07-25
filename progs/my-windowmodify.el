;; You can set this prarmeter for a bigger font
(copy-face 'default 'my/windowmodify/big)
;; just to backup the default face
;; Don't touch it!
(copy-face 'default 'my/windowmodify/default)

(defun my-windowmodify-mode ()
	"This mode will change the font size, you need to resize the window"
	(set-frame-font my/windowmodify/font-big nil t nil)
	(add-hook 'window-size-change-functions (lambda (a)
																						(run-if-monitor))))

(defun run-if-monitor ()
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		;; (message "%s" dp)
		(if (< dp -20)
				(set-face-attribute 'default (face-attribute 'my/windowmodify/big :height))
			(set-face-attribute 'default (face-attribute 'my/windowmodify/default :height)))))

(provide 'my-windowmodify)
