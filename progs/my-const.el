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

(defun my/theme () (my/light-theme))
;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	;; add shell
	;; (setq explicit-shell-file-name "c:/msys64/usr/bin/zsh.exe")
	;; (setq shell-file-name "zsh")
	;; (setq explicit-zsh.exe-args '("--login" "-i"))
	;; (setenv "SHELL" shell-file-name)
	;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

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
																	(disable-theme 'doom-monokai-octagon)
																	(load-theme 'doom-one)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'doom-one)
																	 (load-theme 'doom-monokai-octagon)))
	;; modus-operandi theme changing
	;; (eval-after-load 'magit-status
	;; 	(custom-set-faces
	;; 	 '(magit-diff-added ((t (:extend t :background "pale green" :foreground "steel blue"))))
	;; 	 '(magit-diff-removed ((t (:extend t :background "#ffe8ef" :foreground "orange red"))))
	;; 	 '(magit-section-highlight ((t (:extend t :background "ghost white"))))))

	;; msys2 find dir in windows
	(setq find-program "c:/msys64/usr/bin/find.exe")
	
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
	(setq centaur-tabs-cycle-scope 'tabs)
	(custom-set-variables
	 '(centaur-tabs-hide-tabs-hooks
		 '(magit-popup-mode-hook reb-mode-hook completion-list-mode-hook)))

	(defun centaur-tabs-buffer-groups ()
    (list
		 (cond
			((and
				(string-prefix-p "*" (buffer-name))
				(not (my/check/start-with-in-list (buffer-name) '("*scratch*" "*HTTP Response*" "*Customize" "*Colors*"))))
			 "Messages")
			((string-equal "COMMIT_EDITMSG" (buffer-name)) "Magitcommitmsg")
			(t
			 "All"))))
	(centaur-tabs-mode +1)
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
