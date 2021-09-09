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
	(straight-use-package 'color-theme-sanityinc-tomorrow)
	(add-hook 'my/dark-theme-hook (lambda ()
																	(load-theme 'sanityinc-tomorrow-night)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (load-theme 'sanityinc-tomorrow-day)))
	(add-to-list 'default-frame-alist '(fullscreen . maximized)))

(setq browse-url-generic-program "firefox")

(provide 'my-const)
