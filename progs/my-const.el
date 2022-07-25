;; -*- lexical-binding: t -*-

(defcustom my/project-dir "/home/lbodnar/Projects" "")
(defcustom my/notes-dir "/home/lbodnar/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/" "")
(defcustom my/temp-dir "/home/lbodnar/Projects/temp" "")
(defcustom my/const/gitk-exe--path "/usr/bin/gitk" "")
(defcustom my/const/git-gui-exe--path "/usr/bin/git" "")
(defcustom my/modules '(my-prog my-dev my-haskell my-web) "The modules, what you use")

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
	
		;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized)))
 
(provide 'my-const)
