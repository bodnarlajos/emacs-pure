;; -*- lexical-binding: t -*-

;; (when (not (string-equal system-type "windows-nt"))
;;   ;; because windows use utf-16
;;   (setq current-language-environment "UTF-8")
;;   (prefer-coding-system 'utf-8)
;;   (set-default-coding-systems 'utf-8)
;;   (set-language-environment 'utf-8)
;;   (set-selection-coding-system 'utf-8)
;;   )

(set-default-coding-systems 'utf-8)

(setq inhibit-startup-screen t
      visible-bell t
      create-lockfiles nil
      sentence-end-double-space nil
      emacs-lisp-docstring-fill-column 'fill-column
      calendar-week-start-day 1
      select-enable-clipboard t
      select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      save-place-file (concat user-emacs-directory "places")
      garbage-collection-messages nil)

;; cursor move faster
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling 't)
;; NOTE: setting this to `0' like it was recommended in the article above seems
;; to cause fontification to happen in real time, which can be pretty slow in
;; large buffers. Giving it a delay seems to be better.
(setq jit-lock-defer-time 0.25)

(setq read-process-output-max (* 1024 1024)) ; 1mb.
(setq display-time-world-list '(("Europe/Vienna" "Wien")))

(custom-set-variables
 '(completion-cycle-threshold 3)
 '(tab-always-indent 'complete)
 '(tab-first-completion t)
 '(completions-detailed t)
 '(compilation-scroll-output t)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(global-auto-revert-non-file-buffers t)
 '(next-error-recenter '(4))
 '(fast-but-imprecise-scrolling t)
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(recentf-save-file
   (expand-file-name "recentf" user-emacs-directory))
 '(kill-do-not-save-duplicates t))

(electric-pair-mode 1) ; auto-insert matching bracket
(show-paren-mode +1)    ; turn on paren match highlighting
(winner-mode 1)
(global-visual-line-mode 1)
(setq-default frame-title-format "%b (%f)")
;; use ls-lisp instead of ls
(setq ls-lisp-use-insert-directory-program nil)
(set-window-scroll-bars (minibuffer-window) nil nil)


(add-to-list 'display-buffer-alist
	     '("\\*\\(Completions\\|Help\\)\\*"
	       (display-buffer-reuse-window display-buffer-pop-up-window)
	       (window-width . 60)
	       (side . right)
               (slot . 3)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(eldoc\\)\\*"
	       (display-buffer-reuse-window display-buffer-in-side-window)
	       (window-width . 60)
               (window-parameters . ((no-other-window . t)(no-delete-other-windows . t)))
               (dedicated . t)
	       (side . right)
               (slot . 5)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(compilation\\|Async\\)\\*"
	       (display-buffer-reuse-window display-buffer-in-side-window)
	       (window-width . 60)
               (window-parameters . ((no-other-window . t)(no-delete-other-windows . t)))
               (dedicated . t)
	       (side . right)
               (slot . 7)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(Flymake diag.+\\)\\*"
	       (display-buffer-reuse-window display-buffer-in-side-window)
	       (window-width . 60)
	       (side . right)
               (slot . 2)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(Compile-Log\\|Async-native-compile-log\\|Warnings\\)\\*"
	       (display-buffer-no-window)
	       (allow-no-window t)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(Ibuffer\\|vc-dir\\|vc-diff\\|vc-change-log\\|Async Shell Command\\)\\*"
	       (display-buffer-full-frame)))

(add-to-list 'display-buffer-alist
	     '("\\(magit: .+\\|magit-log.+\\|magit-revision.+\\)"
	       (display-buffer-full-frame)))

(global-set-key [remap list-buffers] #'ibuffer-list-buffers)
(global-auto-revert-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(delete-selection-mode)
(setq-default indent-tabs-mode nil
	      standard-indent 2
              tab-width 2
	      delete-old-versions t
              display-line-numbers-width 4
	      create-lockfiles nil
              dired-kill-when-opening-new-dired-buffer t
	      left-fringe-width 10
	      column-number-mode t)
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add 'yes-or-no-p :override #'y-or-n-p))
(recentf-mode +1)
;; (desktop-save-mode +1)

(setq auto-window-vscroll nil)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)

;; backup/autosave dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
(setq tramp-backup-directory-alist `(("." . ,(concat user-emacs-directory "remote-file-backups"))))
(let ((my-auto-save-dir (locate-user-emacs-file "auto-save")))
  (setq auto-save-file-name-transforms
        `((".*" ,(expand-file-name "\\2" my-auto-save-dir) t)))
  (unless (file-exists-p my-auto-save-dir)
    (make-directory my-auto-save-dir)))
(setq auto-save-default t
      auto-save-timeout 10
      auto-save-interval 200)

(global-so-long-mode 1)

(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(require 'savehist)
(setq savehist-additional-variables '(regexp-search-ring)
      savehist-autosave-interval 60
      savehist-file (expand-file-name "savehist" user-emacs-directory))
(savehist-mode t)

(require 'saveplace)
(save-place-mode t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(require 'defuns)
;; (require 'package-init)
(require 'package-straight-init)
(require 'extra-packages)
;; (require 'keys)
(require 'keys-wakib)
(require 'expensive-packages)

(with-eval-after-load 'org
  (custom-set-variables
   '(org-adapt-indentation 'headline-data)
   '(org-support-shift-select t)
   '(org-startup-indented t)))

(add-hook 'diff-mode-hook #'(lambda () (diff-auto-refine-mode t)))

(with-eval-after-load 'ediff
  ;; add ediff configuration
  (set-face-attribute 'ediff-even-diff-A nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-B nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-C nil :inherit nil)
  (setq ediff-split-window-function 'split-window-horizontally
        ediff-merge-split-window-function 'split-window-vertically
        ediff-diff-options "-w"
        ediff-ignore-similar-regions t
        ediff-window-setup-function #'ediff-setup-windows-plain)
  (defun disable-y-or-n-p (orig-fun &rest args)
    (cl-letf (((symbol-function 'y-or-n-p) (lambda (prompt) t)))
      (apply orig-fun args)))
  (advice-add 'ediff-quit :around #'disable-y-or-n-p))

(setq vc-handled-backends '(Git)
      vc-git-show-stash 3)

(defvar my/notes-path "")
(setq custom-file (expand-file-name (concat "~/.emacs.d/lisp/custom-" (system-name) ".el")))
(message "Custom file path: %s" custom-file)
(load custom-file)

(pixel-scroll-precision-mode +1)
(context-menu-mode +1)

;; tab-bar and mode-line
(setq-default header-line-format nil)
;; (tab-bar-mode t)
(setq tab-bar-show 1)
(setq tab-bar-close-button-show nil)
(setq tab-bar-new-tab-choice "*scratch*")
(setq tab-bar-tab-hints t)
(setq-default tab-bar-tab-name-function 'tab-bar-tab-name-truncated)
(setq tab-bar-tab-name-truncated-max 30)
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
;; (global-tab-line-mode +1)
(custom-set-faces
 '(tab-bar ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0)))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (4 . 4) :style flat-button) :underline (:color foreground-color :style line :position 0)))))
 '(tab-line ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0) :box (:line-width (4 . 4) :style flat-button)))))
 '(tab-line-tab ((t (:inherit tab-line :style flat-button) :underline (:color foreground-color :style line :position 0)))))

(require 'server)
(unless (server-running-p)
  (setq frame-title-format "Server [%b]")
  (server-start)
  (message "server-mode started"))

(defvar my/path-separator ":")
(when (eq system-type 'windows-nt)
  (setq my/path-separator ";"))

(use-package eldoc
  :init
  :ensure nil
  :preface
  (setq eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly))

(add-hook 'after-init-hook
	  (lambda ()
	    (setenv "PATH" (concat (string-join exec-path my/path-separator) my/path-separator (getenv "PATH")))
            (message "exec-path -> $PATH")))

(use-package emacs
  :config
  (setq project-switch-commands '((project-find-file "Find file")
                                  (project-find-dir "Find directory")
                                  (/start-magit "Git" "g")
                                  (project-eshell "Eshell")))
  (size-indication-mode t)
  (setq isearch-lazy-count t
        lazy-count-prefix-format "(%s/%s) => "
        lazy-count-suffix-format ""
        search-whitespace-regexp ".*?"))


(put 'upcase-region 'disabled nil)
