;; -*- lexical-binding: t -*-

(defconst my/project-dir '("/home/lbodnar/Projects"))
(defconst my/exec-dir '("/home/lbodnar/.local/bin" "/home/lbodnar/.ghcup/bin"))
(defconst my/notes-dir "/home/lbodnar/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/")
(defconst my/base-dir "/home/lbodnar/Projects")
(defconst my/temp-dir "/home/lbodnar/Projects/temp")
(defconst my/const/gitk-exe--path "/usr/bin/gitk")
(defconst my/const/git-gui-exe--path "/usr/bin/git")

(defun my/start-modules ()
	"Start these modules after init"
	(interactive)
	(require 'my-prog)
	(require 'my-dev)
	(require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)
	;; (require 'my-windowmodify)
	)

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(defvar my/is-mswindows (when (string-equal "windows-nt" 'system-type)))

	(when my/is-mswindows
		(progn
			(defvar my/git-bash-bin-path "C:/Program Files/Git/usr/bin/")
			(custom-set-variables
			 '(ediff-diff-program (concat my/git-bash-bin-path "diff.exe"))
			 '(ediff-diff3-program (concat my/git-bash-bin-path "diff3.exe"))
			 '(ediff-custom-diff-program (concat my/git-bash-bin-path "diff3.exe")))
			(setq find-program (concat my/git-bash-bin-path "find.exe"))))

	;; set the font based on the monitor
	;; (setq my/windowmodify/font "Ubuntu Mono-11")
	;; (setq my/windowmodify/font-big "Ubuntu Mono-13")
	;; (my-windowmodify-mode)
	
	
	(my/start-modules)
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	(use-package org
		:config
		(setq org-agenda-files (list
														"~/Box/notes/daily.org")))
	)

(setq browse-url-generic-program "firefox")

(provide 'my-const)
