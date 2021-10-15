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

	(add-hook 'my/dark-theme-hook (lambda ()
																	(disable-theme 'tsdh-light)
																	(load-theme 'tsdh-dark)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'tsdh-dark)
																	 (load-theme 'tsdh-light)))
	(add-to-list 'default-frame-alist '(height . 45))
  (add-to-list 'default-frame-alist '(width . 140))
	(set-frame-size (selected-frame) 140 45))

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
