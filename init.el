;; -*- lexical-binding: t -*-

(setq inhibit-startup-screen t
      visible-bell t)
(customize-set-variable 'completion-cycle-threshold 3)
(customize-set-variable 'tab-always-indent 'complete)
(customize-set-variable 'completions-detailed t)
(electric-pair-mode 1) ; auto-insert matching bracket
(show-paren-mode +1)    ; turn on paren match highlighting
(winner-mode 1)
(global-visual-line-mode 1)

(add-to-list 'display-buffer-alist
	     '("\\*\\(Completions\\|Help\\)\\*"
	       (display-buffer-reuse-window display-buffer-pop-up-window)
	       (window-height . 30)
	       (side . bottom)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(eldoc\\)\\*"
	       (display-buffer-reuse-window display-buffer-in-side-window)
	       (window-width . 80)
	       (side . right)
               (slot . 1)))

(add-to-list 'display-buffer-alist
	     '("\\*\\(Flymake diag.+\\)\\*"
	       (display-buffer-reuse-window display-buffer-in-side-window)
	       (window-width . 80)
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

(customize-set-variable 'switch-to-buffer-in-dedicated-window 'pop)
(customize-set-variable 'switch-to-buffer-obey-display-actions t)
(customize-set-variable 'ibuffer-movement-cycle nil)
(customize-set-variable 'ibuffer-old-time 24)
(global-set-key [remap list-buffers] #'ibuffer-list-buffers)
(customize-set-variable 'global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(delete-selection-mode)
(setq-default indent-tabs-mode nil
	      standard-indent 2
	      delete-old-versions t
              display-line-numbers-width 4
	      create-lockfiles nil
              dired-kill-when-opening-new-dired-buffer t
	      left-fringe-width 10
	      column-number-mode t)
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add 'yes-or-no-p :override #'y-or-n-p))
(customize-set-variable 'recentf-save-file
			(expand-file-name "recentf" user-emacs-directory))
(recentf-mode +1)

(customize-set-variable 'kill-do-not-save-duplicates t)
(setq auto-window-vscroll nil)
(customize-set-variable 'fast-but-imprecise-scrolling t)
(customize-set-variable 'scroll-conservatively 101)
(customize-set-variable 'scroll-margin 0)
(customize-set-variable 'scroll-preserve-screen-position t)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)

;; backup/autosave dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
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
(savehist-mode t)
(save-place-mode t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(require 'defuns)
(require 'extra-packages)
(require 'keys)
(require 'eglot-lsp)

(custom-set-variables
 '(next-error-recenter '(4)))

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
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-vertically)
  (setq ediff-diff-options "-w")
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
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

(defvar my/path-separator ":")
(when (eq system-type 'windows-nt)
  (setq my/path-separator ";"))

;; tab-bar and mode-line
(setq-default header-line-format "")
(tab-bar-mode 1)
(setq tab-bar-show 1)
(setq tab-bar-close-button-show nil)
(setq tab-bar-new-tab-choice "*scratch*")
(setq tab-bar-tab-hints t)
(setq-default tab-bar-tab-name-function 'tab-bar-tab-name-truncated)
(setq tab-bar-tab-name-truncated-max 30)
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

(custom-set-faces
 '(header-line ((t (:inherit default :box (:line-width (1 . 1) :style flat-button)))))
 '(tab-bar ((t (:inherit mode-line :box (:line-width (2 . 6) :style flat-button) :height 100))))
 '(tab-bar-tab ((t (:inherit mode-line :box (:line-width (2 . 6) :style flat-button)))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive)))))

(require 'server)
(unless (server-running-p)
  (setq frame-title-format "Server [%b]")
  (server-start)
  (message "server-mode started"))

(add-hook 'after-init-hook
	  (lambda ()
	    (setenv "PATH" (concat (string-join exec-path my/path-separator) my/path-separator (getenv "PATH")))
            (message "exec-path -> $PATH")))

