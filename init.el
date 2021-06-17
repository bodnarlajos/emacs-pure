;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; ;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; (message "%s" file-name-handler-alist)
;; (setq debug-on-error t)

;;(defalias 'yes-or-no-p 'y-or-n-p)	

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-check-for-modifications nil)

(defun my/set-font ()
	"Set the default font"
	(if is-lbodnar
			(progn
				(add-to-list 'default-frame-alist '(font . "Hack-11")))
		(progn
			(add-to-list 'default-frame-alist '(font . "Hack-10"))
			(set-face-attribute 'default nil :family "Hack" :foundry "CTDB" :height 90))))

(my/set-font)

(setq frame-title-format '("%b"))
(setq file-name-handler-alist nil)

(cua-mode t)
(blink-cursor-mode 0)

;; (straight-use-package 'magit)

(straight-use-package 'spacemacs-theme)

(custom-set-variables
 '(custom-safe-themes
	 '("66f32da4e185defe7127e0dc8b779af99c00b60c751b0662276acaea985e2721" "a99fb53a1d22ce353cab8db2fe59353781c13a4e1d90455f54f7e60c061bc9f4" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476")))

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

(straight-use-package 'selectrum)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'consult)
(selectrum-mode +1)
;; to make sorting and filtering more intelligent
(selectrum-prescient-mode +1)

;; to save your command history on disk, so the sorting gets more
;; intelligent over time
(prescient-persist-mode +1)

(let ((my-load-file
			 (expand-file-name (concat user-emacs-directory "progs"))))
  (add-to-list 'load-path my-load-file))
(require 'my-defun)
(require 'my-const)

(my/light-theme)

(straight-use-package 'rg)
(straight-use-package 'undo-tree)
(global-undo-tree-mode)
(straight-use-package 'smex)
(recentf-mode)
(require 'my-keys)
(require 'my-setq-defaults)
(require 'my-layout)
(straight-use-package 'ctrlf)
(ctrlf-mode +1)
(straight-use-package 'markdown-mode)
(show-paren-mode +1)

(add-hook 'nxml-mode-hook 'my/long-line)
(add-hook 'json-mode-hook 'my/long-line)
(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)

(defvar my/dev-hook '())
(defvar my/dev-env nil)

;; add exec-path
(mapcar (lambda (cdir)
					(add-to-list 'exec-path cdir)) my/exec-dir)
(mapcar (lambda (cdir)
					(setenv (concat cdir ";" (getenv "PATH")))) my/exec-dir)
(setq find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(with-eval-after-load 'ediff
	;; add ediff configuration
	(setq ediff-split-window-function 'split-window-horizontally)
	(setq ediff-merge-split-window-function 'split-window-vertically)
	(setq ediff-diff-options "-w")
	(setq ediff-window-setup-function #'ediff-setup-windows-plain))

(straight-use-package 'doom-modeline)
(doom-modeline-mode +1)
(custom-set-variables
 '(consult-buffer-filter
	 '("\\` "
		 "\\`\\*Completions\\*\\'"
		 "\\`\\*Flymake log\\*\\'"
		 "\\`\\*Semantic SymRef\\*\\'"
		 "\\`\\*Messages\\*\\'"
		 "\\`\\*straight.*\\*\\'"
		 "\\`\\*tramp/.*\\*\\'")))

;; #######################
;; Modules
;; #######################
;; Haskell
(defun my/init-haskell ()
	"Init haskell function"
	(require 'my-haskell)
	(setq auto-mode-alist (delete my/init-haskell-type auto-mode-alist))
	;; (require 'my-dev)
	(my/revert-current-buffer))

(defvar my/init-haskell-type '("\\.hs\\'" . my/init-haskell))
(add-to-list 'auto-mode-alist my/init-haskell-type)
;; Web
(defun my/init-web ()
	"Init haskell function"
	(require 'my-web)
	(setq auto-mode-alist (delete my/init-web-type auto-mode-alist))
	(my/revert-current-buffer))

(defvar my/init-web-type '("\\.\\(?:less\\|ts\\|htm\\|html\\|css\\|js\\)\\'" . my/init-web))
(add-to-list 'auto-mode-alist my/init-web-type)
;; Org
(eval-after-load 'org-mode
	(setq org-todo-keywords
				'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
				org-support-shift-select t
				org-log-done t))
;; C#
(defun my/init-cs ()
	"Init csharp function"
	(require 'my-csharp)
	(setq auto-mode-alist (delete my/init-cs-type auto-mode-alist))
	;; (require 'my-dev)
	(my/revert-current-buffer))

(defvar my/init-cs-type '("\\.\\(?:cs\\|csproj\\)\\'" . my/init-cs))
(add-to-list 'auto-mode-alist my/init-cs-type)

(add-hook 'so-long-mode-hook (lambda ()
															 (require 'longlines)
															 (longlines-mode)))

(straight-use-package 'centaur-tabs)
(centaur-tabs-mode +1)

(when my/autostart-dev-env
	(require 'my-dev))
