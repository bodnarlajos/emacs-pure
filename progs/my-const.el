;; -*- lexical-binding: t -*-

(defgroup my/configs nil "My configurations")
(defcustom my/font-family "Ubuntu Mono" "The font family" :type 'string :group 'my/configs)
(defcustom my/font-size 140 "The font size" :type 'integer :group 'my/configs)
(defcustom my/font-weight 'normal "The font weight" :type 'symbol :group 'my/configs)
(defcustom my/project-dir "/home/lbodnar/Projects" "" :type 'string :group 'my/configs)
(defcustom my/notes-dir "/home/lbodnar/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/" "" :type 'string :group 'my/configs)
(defcustom my/temp-dir "/home/lbodnar/Projects/temp" "" :type 'string :group 'my/configs)
(defcustom my/const/gitk-exe--path "/usr/bin/gitk" "" :type 'string :group 'my/configs)
(defcustom my/const/git-gui-exe--path "/usr/bin/git" "" :type 'string :group 'my/configs)
(defcustom my/modules '(my-custom my-prog my-haskell my-web my-themes) "The modules, what you use" :type '(list symbol) :group 'my/configs)
(defcustom my/menu-items '(("IDE" . my/run/bloated-hook) ("My-config" . my/open/my-config) ("Open desktop" . my/open/desktop) ("*Scratch*" . my/open/scratch) ("Notes" . my/open-notes) ("VC" . vc-dir) ("Git" . my/goto-magit) ("Files" . project-find-file) ("Ripgrep" . rg) ("Open file" . find-file) ("Buffers" . consult-buffer)) "My-config menu items" :type '(alist :key-type string :value-type function) :group 'my/configs)
(defcustom my/bloated-hook '(my-dev-lsp-mode) "The bloated modes, functions" :type '(repeat function) :group 'my/configs)
(defvar my/is-mswindows (when (string-equal "windows-nt" 'system-type)))

(defun my/run/bloated-hook ()
	"Run the development environment"
	(interactive)
	(mapc (lambda (m)
					(require m)) my/bloated-hook)
	(revert-buffer nil t))

;; end script of init
(defun my/end-of-init ()
	"The custom script end of the initialization"

	(when my/is-mswindows
		(progn
			(defvar my/git-bash-bin-path "C:/Program Files/Git/usr/bin/")
			(custom-set-variables
			 '(ediff-diff-program (concat my/git-bash-bin-path "diff.exe"))
			 '(ediff-diff3-program (concat my/git-bash-bin-path "diff3.exe"))
			 '(ediff-custom-diff-program (concat my/git-bash-bin-path "diff3.exe")))
			(setq find-program (concat my/git-bash-bin-path "find.exe"))))

	;; set the font based on the monitor
	;; (setq my/windowmodify/font "Ubuntu Mono-11")
	;; (setq my/windowmodify/font-big "Ubuntu Mono-13")
	;; (my-windowmodify-mode)
	
	;; fullscreen
	(add-to-list 'default-frame-alist '(fullscreen . maximized)))

(provide 'my-const)
