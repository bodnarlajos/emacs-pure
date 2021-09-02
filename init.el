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

(setq straight-check-for-modifications nil)

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

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

(straight-use-package 'selectrum)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'consult)
(selectrum-mode +1)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)

(load (expand-file-name (concat user-emacs-directory "custom.el")))
(require 'my-defun)
(straight-use-package 'rg)
(straight-use-package 'undo-tree)
(global-undo-tree-mode)
(straight-use-package 'smex)
(require 'my-keys)
(require 'my-setq-defaults)
(require 'my-layout2)
(straight-use-package 'ctrlf)
(straight-use-package 'markdown-mode)
(straight-use-package 'transpose-frame)
(straight-use-package 'doom-modeline)

(doom-modeline-mode +1)
(ctrlf-mode +1)
(show-paren-mode +1)
(recentf-mode)

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
(add-hook 'so-long-mode-hook (lambda ()
			       (require 'longlines)
			       (longlines-mode)))

(cd my/base-dir)

(cua-mode t)
(blink-cursor-mode 0)
(set-cursor-color "red")
(setq-default cursor-type 'bar)
(when (not is-lbodnar)
	(set-frame-size (selected-frame) 180 60))

(my/theme)

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
(require 'my-csharp)

;; End of modules
(when my/autostart-dev-env
	(require 'my-dev))
