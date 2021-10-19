;; -*- lexical-binding: t -*-

(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("c:/ProgramData/Git/usr/bin" "c:/ProgramData/chocolatey/bin" "c:/ProgramData/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")

(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (my/light-theme))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"

	(require 'my-dev)
	;; (require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)

	(eval-after-load 'org-mode
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t))

	(straight-use-package 'doom-themes)
	(add-hook 'my/dark-theme-hook (lambda ()
																	(disable-theme 'doom-one-light)
																	(load-theme 'doom-one)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'doom-one)
																	 (load-theme 'doom-one-light)))
	;; The window initial size
	;; specified size
  (add-to-list 'default-frame-alist '(width . 160))
	(add-to-list 'default-frame-alist '(height . 45))
	(add-to-list 'default-frame-alist '(left . 400))
	(add-to-list 'default-frame-alist '(top . 10))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
	(setq centaur-tabs-height 32)
	(setq centaur-tabs-set-icons t)
	(setq centaur-tabs-plain-icons t)
	;; (setq centaur-tabs-set-bar 'left)
	(setq centaur-tabs-set-bar 'under)
	(setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "●")	
	(centaur-tabs-mode +1)
	(defun centaur-tabs-buffer-groups ()
    (list
		 (cond
			((and
				(string-equal "*" (substring (buffer-name) 0 1))
				(not (member (buffer-name) '("*scratch*" "*HTTP Response*"))))
			 "Messages")
			((string-equal "COMMIT_EDITMSG" (buffer-name)) "Magitcommitmsg")
			(t
			 "All"))))
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
