;; -*- lexical-binding: t -*-

(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("C:/Program Files/Git/usr/bin/" "c:/ProgramData/chocolatey/bin" "C:/Program Files/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")
(defvar my/project-dir '("/home/lbodnar/Projects"))
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
(defvar my/notes-dir "/home/lbodnar/Documents/notes/")
(defvar my/base-dir "/home/lbodnar/Projects")
(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (load-theme 'modus-operandi))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	;; add shell
	(setq explicit-shell-file-name "C:/Program Files/Git/usr/bin/zsh.exe")
	(setq shell-file-name "C:/Program Files/Git/usr/bin/zsh.exe")
	(setq explicit-zsh.exe-args '("--login" "-i"))
	(setenv "SHELL" shell-file-name)
	(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
	(custom-set-variables
	 '(ediff-diff-program "C:/Program Files/Git/usr/bin/diff.exe")
	 '(ediff-diff3-program "C:/Program Files/Git/usr/bin/diff3.exe")
	 '(ediff-custom-diff-program "C:/Program Files/Git/usr/bin/diff3.exe"))
	(setq find-program "C:/Program Files/Git/usr/bin/find.exe")
	
	(require 'my-dev)
	;; (require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)

	(eval-after-load 'org-mode
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t)
		(custom-set-faces
		 '(org-level-1 ((t (:inherit outline-1 :height 2.0))))
		 '(org-level-2 ((t (:inherit outline-2 :height 1.5))))
		 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
		 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
		 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
		 ))
	;; The window initial size
	;; specified size
  (add-to-list 'default-frame-alist '(width . 220))
	(add-to-list 'default-frame-alist '(height . 55))
	(add-to-list 'default-frame-alist '(left . 200))
	(add-to-list 'default-frame-alist '(top . 10))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
	) ;; end of my/end-of-init 

(setq browse-url-generic-program "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")

;; (defun my/set-bigger-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Iosevka" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))))
;; (defun my/set-normal-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Iosevka" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))))

;; (add-hook 'window-size-change-functions (lambda (a)
;; 																					(run-if-monitor 'my/set-normal-font 'my/set-bigger-font)))

(provide 'my-const)
