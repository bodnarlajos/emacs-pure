(defun my/set-bigger-font ()
	"bigger font size"
	(interactive)
	(custom-set-faces
	 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight regular :height 120 :width normal))))))
(defun my/set-normal-font ()
	"bigger font size"
	(interactive)
	(custom-set-faces
	 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight regular :height 98 :width normal))))))

(defun my-windowmodify-mode ()
	"This mode will change the font size, you need to resize the window"
	(add-hook 'window-size-change-functions (lambda (a)
																						(run-if-monitor 'my/set-normal-font 'my/set-bigger-font))))

(defun run-if-monitor (monitor1 monitor2)
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		(message "%s" dp)
		(if (< dp -20)
				(funcall monitor2)
			(funcall monitor1))))

(provide 'my-windowmodify)
