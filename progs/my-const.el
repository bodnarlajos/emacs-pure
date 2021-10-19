;; -*- lexical-binding: t -*-

;; the projects
(defvar my/project-dir '("/home/lbodnar/Projects"))
;; the exec 
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
;; the notes
(defvar my/notes-dir "/home/lbodnar/Documents/notes/")
;; the start dir
(defvar my/base-dir "/home/lbodnar/Projects")

(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (my/dark-theme))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"

	(require 'my-dev)
	(require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)

	(eval-after-load 'org-mode
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t))

	(straight-use-package 'doom-themes)
	(add-hook 'my/dark-theme-hook (lambda ()
																	(disable-theme 'doom-acario-dark)
																	(load-theme 'doom-one)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'doom-one)
																	 (load-theme 'doom-acario-light)))
	;; The window initial size
	;; specified size
  ;; (add-to-list 'default-frame-alist '(width . 140))
	;; (add-to-list 'default-frame-alist '(height . 45))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
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

(setq browse-url-generic-program "firefox")

;; (defun my/set-bigger-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Iosevka" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))))
;; (defun my/set-normal-font ()
;; 	"bigger font size"
;; 	(interactive)
;; 	(custom-set-faces
;; 	 '(default ((t (:family "Iosevka" :foundry "outline" :slant normal :weight normal :height 98 :width normal))))))

;; (add-hook 'window-size-change-functions (lambda (a)
;; 																					(run-if-monitor 'my/set-normal-font 'my/set-bigger-font)))

(provide 'my-const)
