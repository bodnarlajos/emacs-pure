(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(setq my/autostart-dev-env t)
(defvar my/base-dir "c:/Projects")
;; the theme light/dark
(defun my/theme () (my/light-theme))
;; the font
(defun my/set-font ()
	"Set the default font"
	(message "set-font")
	(set-face-attribute 'default nil :family "Iosevka" :height 113))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(set-frame-size (selected-frame) 180 45))

(setq browse-url-generic-program "firefox")

(provide 'my-const)
