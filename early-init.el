;; -*- lexical-binding: t -*-

(defconst my/start-time (current-time))
(defconst my/autostart-dev-env nil)

(defvar file-name-handler-alist-old file-name-handler-alist)
(defconst is-lbodnar (string-equal system-name "debla"))

(setq file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum   ;; Defer Garbage collection
      gc-cons-percentage 1.0)

(add-hook 'emacs-startup-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold (* 100 1024 1024)
                   gc-cons-percentage 0.1)
             (garbage-collect)
             (message "Load time %.06f"
                      (float-time (time-since my/start-time)))) t)

(tool-bar-mode   -1)
(menu-bar-mode   -1)
(scroll-bar-mode -1)
(tooltip-mode    -1) ;; Tool tip in the echo
(flymake-mode -1)

(setq package-enable-at-startup nil)

(setq frame-inhibit-implied-resize t)

(provide 'early-init)
;;; early-init.el ends here 
