;; -*- lexical-binding: t -*-

(tool-bar-mode -1)
(setq inhibit-startup-screen t
      visible-bell t)
(customize-set-variable 'completion-cycle-threshold 3)
(customize-set-variable 'tab-always-indent 'complete)
(customize-set-variable 'completions-detailed t)
(electric-pair-mode 1) ; auto-insert matching bracket
(show-paren-mode 1)    ; turn on paren match highlighting
(winner-mode 1)

(add-to-list 'display-buffer-alist
	     '("\\*\\(Completions\\|Help\\|eldoc.+\\)\\*"
	       (display-buffer-reuse-window display-buffer-pop-up-window)
	       (window-height . 30)
	       (side . bottom)))

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
(repeat-mode 1)
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
	      create-lockfiles nil
              dired-kill-when-opening-new-dired-buffer t
	      left-fringe-width 15
	      column-number-mode t)
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add 'yes-or-no-p :override #'y-or-n-p))
(add-hook 'after-init-hook #'recentf-mode)
(customize-set-variable 'recentf-save-file
			(expand-file-name "recentf" user-emacs-directory))
(customize-set-variable 'kill-do-not-save-duplicates t)
(setq auto-window-vscroll nil)
(customize-set-variable 'fast-but-imprecise-scrolling t)
(customize-set-variable 'scroll-conservatively 101)
(customize-set-variable 'scroll-margin 0)
(customize-set-variable 'scroll-preserve-screen-position t)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)
(global-so-long-mode 1)
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)
(savehist-mode t)
(save-place-mode t)
;; (add-hook 'save-place-after-find-file-hook (lambda ()
;;                                              (timer-set-function 1 (call-interactively 'recenter-top-bottom))))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(require 'defuns)
(require 'extra-packages)
(require 'keys)

(custom-set-variables
 ;; '(completion-styles '(substring basic partial-completion emacs22))
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

(defvar my/path-separator ":")
(when (eq system-type 'windows-nt)
  (setq my/path-separator ";"))

(require 'server)
(unless (server-running-p)
  (server-start))

(add-hook 'after-init-hook
	  (lambda ()
	    (setenv "PATH" (concat (string-join exec-path my/path-separator) my/path-separator (getenv "PATH")))
	    (require 'extra-lsp)))
