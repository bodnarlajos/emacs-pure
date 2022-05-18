(defvar my/windowmodify/font "Dejavu Sans Mono-10")
(defvar my/windowmodify/font-big "Dejavu Sans Mono-12")

(defun my-windowmodify-mode ()
	"This mode will change the font size, you need to resize the window"
	(add-hook 'window-size-change-functions (lambda (a)
																						(run-if-monitor))))

(defun run-if-monitor ()
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		;; (message "%s" dp)
		(if (< dp -20)
				(set-frame-font my/windowmodify/font-big)
			(set-frame-font my/windowmodify/font))))

(provide 'my-windowmodify)
