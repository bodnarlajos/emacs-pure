(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")
(defvar my/dark-theme-hook '())
(defvar my/light-theme-hook '())

(defun my/theme () (my/light-theme))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	;; (straight-use-package 'color-theme-sanityinc-tomorrow)
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	(add-hook 'my/dark-theme-hook (lambda ()
																	(load-theme 'wombat)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'wombat)))
	(set-frame-size (selected-frame) 140 45))

(setq browse-url-generic-program "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")

(provide 'my-const)
