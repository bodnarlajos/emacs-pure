;; -*- lexical-binding: t -*-

;; the projects
(defvar my/project-dir '("/home/lbodnar/Projects"))
;; the exec 
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
;; the notes
(defvar my/notes-dir "/home/lbodnar/Documents/notes/")
;; the start dir
(defvar my/base-dir "/home/lbodnar/Projects")
;;
(defvar my/dark-theme-hook '())
(defvar my/light-theme-hook '())
(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (my/light-theme))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	(add-to-list 'default-frame-alist '(fullscreen . maximized))

	(require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)
	(require 'my-dev)

	(eval-after-load 'org-mode
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t))

	(add-hook 'my/dark-theme-hook (lambda ()
																	(disable-theme 'tsdh-light)
																	(load-theme 'wombat)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'wombat)
																	 (load-theme 'tsdh-light)))
	(add-to-list 'default-frame-alist '(height . 45))
  (add-to-list 'default-frame-alist '(width . 140))
	(set-frame-size (selected-frame) 140 45))

(setq browse-url-generic-program "firefox")

(provide 'my-const)
