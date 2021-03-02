(defconst my/start-time (current-time))

(defvar file-name-handler-alist-old file-name-handler-alist)
(defconst is-lbodnar (string-equal system-name "lbodnar"))

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

;;__________________________________________________________
;; For using Melpa and Elpa
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-method 'bitmap)
 '(package-selected-packages
   '(selectrum zoom treemacs company-quickhelp lsp-ui lsp-mode haskell-mode lsp-haskell flycheck tide web-mode js2-mode undo-tree smex smartparens rg hydra highlight-indent-guides haskell-mode eglot dumb-jump diff-hl company)))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(setq package-quickstart t)

(setq frame-inhibit-implied-resize t)
(if is-lbodnar
    (progn
      (add-to-list 'default-frame-alist '(font . "Fira Code-12"))
      (set-face-attribute 'default nil :family "Fira Code" :height 110))
  (progn
    (add-to-list 'default-frame-alist '(font . "Fira Code-12"))
    (set-face-attribute 'default nil :family "Fira Code" :height 100)))

;;   (set-frame-font "" t)
;; (set-frame-font "Fira Code-9" t))

(defalias 'yes-or-no-p 'y-or-n-p)

;;-------------------- Some tricks--------------------------
(provide 'early-init)
;;; early-init.el ends here 
