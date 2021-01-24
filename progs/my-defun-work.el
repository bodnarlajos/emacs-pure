(defun find-in-log (text)
	"T."
	(interactive "sCount: ")
	(rg text "*.log" "c:/logfiles"))

(provide 'my-defun-work)
