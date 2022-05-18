(defvar my/window-modify/font "Ubuntu Mono-8")
(defvar my/window-modify/font-big "Ubuntu Mono-10")

(defun my/set-bigger-font ()
	"bigger font size"
	(interactive)
	(set-frame-font my/window-modify/font-big))

(defun my/set-normal-font ()
	"bigger font size"
	(interactive)
	(set-frame-font my/window-modify/font))

(defun my-windowmodify-mode ()
	"This mode will change the font size, you need to resize the window"
	(add-hook 'window-size-change-functions (lambda (a)
																						(run-if-monitor 'my/set-normal-font 'my/set-bigger-font))))

(defun run-if-monitor (monitor1 monitor2)
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		;; (message "%s" dp)
		(if (< dp -20)
				(funcall monitor2)
			(funcall monitor1))))

(provide 'my-windowmodify)
