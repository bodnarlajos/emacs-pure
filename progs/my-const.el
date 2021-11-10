;; -*- lexical-binding: t -*-

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
	(straight-use-package 'org-bullets)
	(org-bullets-mode +1)
	(custom-set-faces
	 '(magit-diff-added ((t (:extend t :background "#d4fad4" :foreground "#004500" :inverse-video t))))
	 '(magit-diff-removed ((t (:extend t :background "#ffe8ef" :foreground "#691616" :inverse-video t))))
	 '(org-level-1 ((t (:inherit outline-1 :height 2.0))))
	 '(org-level-2 ((t (:inherit outline-2 :height 1.5))))
	 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
	 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
	 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
	;; The window initial size
	;; specified size
  ;; (add-to-list 'default-frame-alist '(width . 140))
	;; (add-to-list 'default-frame-alist '(height . 45))
	;; (set-frame-size (selected-frame) 140 45))
	;; fullscreen
	;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
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
