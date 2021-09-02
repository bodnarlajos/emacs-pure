;; the projects
(defvar my/project-dir '("/home/lbodnar/Projects"))
;; the exec 
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
;; the notes
(defvar my/notes-dir "/home/lbodnar/Documents/notes/")
;; the start dir
(defvar my/base-dir "/home/lbodnar/Projects")
;; the theme light/dark
(defun my/theme () (my/dark-theme))
;; the font
(defun my/set-font ()
	"Set the default font"
	(if is-lbodnar
			(progn
				(add-to-list 'default-frame-alist '(font . "Hack-12")))
		(progn
			(add-to-list 'default-frame-alist '(font . "Hack-11"))
			(set-face-attribute 'default nil :family "Hack" :foundry "CTDB" :height 90))))
;; set browser
(setq browse-url-generic-program "firefox")

(provide 'my-const)
