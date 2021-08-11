(defconst my/start-time (current-time))
(defconst my/autostart-dev-env t)

(defvar file-name-handler-alist-old file-name-handler-alist)
(defconst is-lbodnar (string-equal system-name "debla"))

(setq file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum   ;; Defer Garbage collection
      gc-cons-percentage 1.0)

(add-hook 'emacs-startup-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)
             (message "Load time %.06f"
                      (float-time (time-since my/start-time)))) t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode   -1)
(menu-bar-mode   -1)
(scroll-bar-mode -1)
(tooltip-mode    -1) ;; Tool tip in the echo
(flymake-mode    -1)

(setq package-enable-at-startup nil)
;;(setq straight-check-for-modifications nil)

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

(straight-use-package 'selectrum)

(setq frame-inhibit-implied-resize t)

(defun my/set-font ()
	"Set the default font"
	(if is-lbodnar
			(progn
				(add-to-list 'default-frame-alist '(font . "Hack-11")))
		(progn
			(add-to-list 'default-frame-alist '(font . "Hack-10"))
			(set-face-attribute 'default nil :family "Hack" :foundry "CTDB" :height 90))))

(my/set-font)

(defalias 'yes-or-no-p 'y-or-n-p)

;;-------------------- Some tricks--------------------------
(provide 'early-init)
;;; early-init.el ends here 
