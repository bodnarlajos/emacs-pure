;; -*- lexical-binding: t -*-

(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("C:/Program Files/Git/usr/bin/" "c:/ProgramData/chocolatey/bin" "C:/Program Files/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")

(defun my/start-modules ()
	"Start these modules after init"
	(interactive)
	(require 'my-prog)
	(require 'my-dev)
	(require 'my-haskell)
	(require 'my-web)
	(my-web-mode)
	(require 'my-csharp)
	(require 'my-magit)
	(require 'my-windowmodify)
	(my-windowmodify-mode))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(defvar my/is-mswindows (when (string-equal "windows-nt" 'system-type)))
	;; add shell
	;; (setq explicit-shell-file-name "c:/msys64/usr/bin/zsh.exe")
	;; (setq shell-file-name "zsh")
	;; (setq explicit-zsh.exe-args '("--login" "-i"))
	;; (setenv "SHELL" shell-file-name)
	;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

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

	;; The window initial size
	;; specified size
	;; (add-to-list 'default-frame-alist '(width . 180))
	;; (add-to-list 'default-frame-alist '(height . 48))
	;; (add-to-list 'default-frame-alist '(left . 200))
	;; (add-to-list 'default-frame-alist '(top . 10))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	)

(setq browse-url-generic-program "firefox")
;; (defun my/set-bigger-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight regular :height 120 :width normal))))))
;; (defun my/set-normal-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight regular :height 98 :width normal))))))

;; (add-hook 'window-size-change-functions (lambda (a)
;; 																					(run-if-monitor 'my/set-normal-font 'my/set-bigger-font)))

(provide 'my-const)
