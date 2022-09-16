;; -*- lexical-binding: t -*-

;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; ;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

(let ((my-load-file
       (expand-file-name (concat user-emacs-directory "progs"))))
  (add-to-list 'load-path my-load-file))

(require 'my-const)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/bodnarlajos/straight.el/master/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-check-for-modifications nil
      straight-use-package-by-default t
      use-package-always-defer t
      completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

(require 'my-defun)
(require 'my-keys)

(straight-use-package 'use-package)
(use-package use-package
  :straight t
  :config
  (setq use-package-always-ensure t))

(require 'my-core)

(require 'server)
(when (not (server-running-p))
	(server-start)
	(when my/is-mswindows
		(find-file (expand-file-name "/daily.org" my/notes-dir))))

;; end of init
;; set browser up
(setq browse-url-generic-program my/browser)
;; run custom init script
(my/end-of-init)
;; load custom file
(when (file-exists-p custom-file)
  (load custom-file))
;; load modules
(mapc (lambda (m)
				(message "%s" m)
				(require m)) my/modules)
;; set the default directory
(cd my/project-dir)
;; set font up
(set-face-attribute 'default nil :family my/font-family :height my/font-size :weight my/font-weight)
;; set the path env. up
(let ((pathseparator (if my/is-mswindows ";" ":")))
	(setenv "PATH" (concat (string-join exec-path pathseparator) pathseparator (getenv "PATH"))))

