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
	(message "set-font")
	(set-face-attribute 'default nil :family "Iosevka" :height 132))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(my/set-font))
(setq browse-url-generic-program "firefox")

(provide 'my-const)
