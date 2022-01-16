;; -*- lexical-binding: t -*-

(defvar my/project-dir '("/home/lbodnar/Projects"))
(defvar my/exec-dir '("/home/lbodnar/.local/bin"))
(defvar my/notes-dir "/home/lbodnar/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes")
(defvar my/base-dir "/home/lbodnar/Projects")
(defvar my/cursor-color "red")
(defvar my/cursor-type 'box)
(defun my/start-modules ()
	"Start these modules after init"
	(interactive)
	(recentf-mode)
	(require 'my-prog)
	(require 'my-dev)
	(require 'my-jump)
	(require 'my-haskell)
	(require 'my-web)
	(require 'my-csharp)
	)

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"
	;; add shell
	;; (setq explicit-shell-file-name "c:/msys64/usr/bin/zsh.exe")
	;; (setq shell-file-name "zsh")
	;; (setq explicit-zsh.exe-args '("--login" "-i"))
	;; (setenv "SHELL" shell-file-name)
	;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

	(eval-after-load 'org-mode
		(progn
			(straight-use-package 'org-bullets)
			(org-bullets-mode +1)
			(setq org-todo-keywords
						'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
						org-support-shift-select t
						org-log-done t)
			(custom-set-faces
			 '(org-level-1 ((t (:inherit outline-1 :height 1.5 :box nil))))
			 '(org-level-2 ((t (:inherit outline-2 :height 1.3 :box nil))))
			 '(org-level-3 ((t (:inherit outline-3 :height 1.2 :box nil))))
			 '(org-level-4 ((t (:inherit outline-4 :height 1.1 :box nil))))
			 '(org-level-5 ((t (:inherit outline-5 :height 1.0 :box nil))))
			 '(org-fontify-done-headline nil)
       '(org-fontify-todo-headline t)
       '(org-fontify-whole-heading-line t)
       '(org-hide-leading-stars t))))
	
	(my/start-modules)
	(straight-use-package 'doom-themes)
	(load-theme 'doom-one)
	
	(custom-set-faces
	 '(mode-line ((t (:height 1.2)))))
	(eval-after-load 'magit
		(custom-set-faces
		 '(magit-section-highlight ((t (:background nil))))))

	;; The window initial size
	;; specified size
  ;; (add-to-list 'default-frame-alist '(width . 140))
	;; (add-to-list 'default-frame-alist '(height . 45))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized))
	;; Windows like epg config
	;; (custom-set-variables
	;;  '(epg-gpg-home-directory "c:/Users/lbodnar/AppData/Roaming/gnupg")
	;;  '(epg-gpg-program "c:/Program Files (x86)/gnupg/bin/gpg.exe")
	;;  '(epg-gpgconf-program "c:/Program Files (x86)/gnupg/bin/gpgconf.exe")
	;;  )
	(set-cursor-color "#ff0000")
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
