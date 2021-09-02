(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(setq my/autostart-dev-env t)
(defvar my/base-dir "c:/Projects")
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

(provide 'my-const)
