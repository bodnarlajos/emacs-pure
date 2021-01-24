(defconst my/start-time (current-time))

(defvar file-name-handler-alist-old file-name-handler-alist)

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

(tool-bar-mode   -1)
(menu-bar-mode   -1)
(scroll-bar-mode -1)
(tooltip-mode    -1) ;; Tool tip in the echo
(flymake-mode    -1)

;;__________________________________________________________
;; For using Melpa and Elpa
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-load-list '((company t) (smex t) (rg t) (undo-tree t))))
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(setq package-quickstart t)

;;-------------------- Some tricks--------------------------
(provide 'early-init)
;;; early-init.el ends here 
