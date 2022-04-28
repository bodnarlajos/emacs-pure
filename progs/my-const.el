;; -*- lexical-binding: t -*-

(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("C:/Program Files/Git/usr/bin/" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/emacs-native/bin" "C:/Program Files/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")

(defvar my/temp-dir "c:/temp")
(defconst my/const/gitk-exe--path "c:/Program Files/Git/cmd/gitk.exe")
(defconst my/const/git-gui-exe--path "c:/Program Files/Git/bin/git.exe")

(defun my/start-modules ()
	"Start these modules after init"
	(interactive)
	(require 'my-prog)
	(require 'my-dev)
	(require 'my-haskell)
	(require 'my-web)
	(my-web-mode)
	(require 'my-csharp)
	(require 'my-windowmodify)
	(my-windowmodify-mode))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(defvar my/is-mswindows (when (string-equal "windows-nt" 'system-type)))

	(when my/is-mswindows
		(progn
			(defvar my/git-bash-bin-path "C:/Program Files/Git/usr/bin/")
			(custom-set-variables
			 '(epg-gpg-home-directory "c:/Users/lbodnar/AppData/Roaming/gnupg")
			 '(epg-gpg-program "c:/Program Files (x86)/gnupg/bin/gpg.exe")
			 '(epg-gpgconf-program "c:/Program Files (x86)/gnupg/bin/gpgconf.exe")
			 )
			(custom-set-variables
			 '(ediff-diff-program (concat my/git-bash-bin-path "diff.exe"))
			 '(ediff-diff3-program (concat my/git-bash-bin-path "diff3.exe"))
			 '(ediff-custom-diff-program (concat my/git-bash-bin-path "diff3.exe")))
			(setq find-program (concat my/git-bash-bin-path "find.exe"))))
	
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	(use-package org
		:config
		(setq org-agenda-files (list
														"~/Box/notes/daily.org")))
	)

(setq browse-url-generic-program "firefox")

(provide 'my-const)
