(defcustom my/windowmodify/big-font-size 140 "The biggest font size")
(defvar my/windowmodify/_original-size_ (face-attribute 'default :height))

(defun my-windowmodify-mode ()
	"This mode will change the font size, you need to resize the window"
	(add-hook 'window-size-change-functions (lambda (a)
																						(run-if-monitor))))

(defun run-if-monitor ()
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		;; (message "%s" dp)
		(if (< dp -20)
				(set-face-attribute 'default :height my/windowmodify/big-font-size)
			(set-face-attribute 'default :height my/windowmodify/big-font-size))))

(provide 'my-windowmodify)
