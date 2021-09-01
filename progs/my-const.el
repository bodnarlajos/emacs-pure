(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(setq my/autostart-dev-env t)
(defvar my/base-dir "c:/Projects")
;; the theme light/dark
(defun my/theme () (my/light-theme))

(provide 'my-const)
