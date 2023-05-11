;; -*- lexical-binding: t -*-

(defvar file-name-handler-alist-old file-name-handler-alist)

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
             (message "Load time %s" (emacs-uptime))) t)

(tool-bar-mode   -1)
(menu-bar-mode   +1)
(scroll-bar-mode +1)
(tooltip-mode    -1) ;; Tool tip in the echo

(setq frame-inhibit-implied-resize t)

(add-hook
 'after-make-frame-functions
 (defun setup-blah-keys (frame)
   (with-selected-frame frame
     (when (display-graphic-p) ; don't remove this condition, if you want
                                        ; terminal Emacs to be usable
       ;; - When you type `Ctrl-i', Emacs see it as `BLAH-i', and NOT as 'Tab'
       ;; - When you type `Ctrl-m', Emacs see it as `BLAH-m', and NOT as 'Return'
       ;; - When you type `Ctrl-[', Emacs see it as `BLAH-lsb', and not as 'Esc'.
       ;;
       ;; That is,
       ;;
       ;; - `Ctrl-i' and 'Tab' keys are different
       ;; - `Ctrl-m' and 'Return' keys are different
       ;; - `Ctrl-[' and 'Esc' keys are different
       ;;
       ;; The three BLAH keys are the bonus keys.
       (define-key input-decode-map (kbd "C-i") [BLAH-i])
       (define-key input-decode-map (kbd "C-[") [BLAH-lsb]) ; left square bracket
       (define-key input-decode-map (kbd "C-m") [BLAH-m])
       ;; You can replace `BLAH-' above with `C-' or
       ;; `CONTROL-', it doesnt' matter.
       ;;
       ;; BLAH is merely a symbol / name; feel free to change
       ;; it to whatever you like .
       ))))

(provide 'early-init)
;;; early-init.el ends here 
