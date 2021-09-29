;; the projects
(defvar my/project-dir '("/home/lbodnar/Projects"))
;; the exec 
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
;; the notes
(defvar my/notes-dir "/home/lbodnar/Documents/notes/")
;; the start dir
(defvar my/base-dir "/home/lbodnar/Projects")
;;
(defvar my/dark-theme-hook '())
(defvar my/light-theme-hook '())
;; the theme light/dark
(defun my/theme () (my/light-theme))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	(add-hook 'my/dark-theme-hook (lambda ()
																	(load-theme 'wombat)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'wombat)))
	(set-frame-size (selected-frame) 140 45))

(setq browse-url-generic-program "firefox")

(provide 'my-const)
