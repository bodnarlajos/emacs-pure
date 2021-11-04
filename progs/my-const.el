;; -*- lexical-binding: t -*-

(defvar my/project-dir '("c:/Projects"))
(defvar my/exec-dir '("C:/Program Files/Git/usr/bin/" "c:/ProgramData/chocolatey/bin" "C:/Program Files/Git/mingw64/bin"))
(defvar my/notes-dir "c:/users/lbodnar/Box/notes/")
(defvar my/base-dir "c:/Projects")

(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)

(defun my/theme () (my/light-theme))
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
					org-log-done t))

	(add-hook 'my/dark-theme-hook (lambda ()
																	(disable-theme 'modus-operandi)
																	(load-theme 'wombat)))
	(add-hook 'my/light-theme-hook (lambda ()
																	 (disable-theme 'wombat)
																	 (load-theme 'modus-operandi)))
	;; modus-operandi theme changing
	(eval-after-load 'magit-status
		(custom-set-faces
		 '(magit-diff-added ((t (:extend t :background "pale green" :foreground "steel blue"))))
		 '(magit-diff-removed ((t (:extend t :background "#ffe8ef" :foreground "orange red"))))))

	;; git-bash find dir in windows
	(setq find-program "C:/Program Files/Git/usr/bin/find.exe")
	
	;; The window initial size
	;; specified size
  (add-to-list 'default-frame-alist '(width . 220))
	(add-to-list 'default-frame-alist '(height . 55))
	(add-to-list 'default-frame-alist '(left . 200))
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
	(setq centaur-tabs-cycle-scope 'tabs)
	(custom-set-variables
	 '(centaur-tabs-hide-tabs-hooks
		 '(magit-popup-mode-hook reb-mode-hook completion-list-mode-hook)))
	(centaur-tabs-mode +1)
	(centaur-tabs-change-fonts "Segoe UI" 100)
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
