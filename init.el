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
             '("\\*\\(Completions\\|Help\\)\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (window-height . 30)
               (side . bottom)))

(add-to-list 'display-buffer-alist
             '("\\*\\(Compile-Log\\|Async-native-compile-log\\)\\*"
               (display-buffer-no-window)
               (allow-no-window t)))

(add-to-list 'display-buffer-alist
             '("\\*\\(vc-dir\\|vc-diff\\|Async Shell Command\\)\\*")
             (display-buffer-full-frame))

(customize-set-variable 'switch-to-buffer-in-dedicated-window 'pop)
(customize-set-variable 'switch-to-buffer-obey-display-actions t)
(repeat-mode 1)
(customize-set-variable 'ibuffer-movement-cycle nil)
(customize-set-variable 'ibuffer-old-time 24)
(global-set-key [remap list-buffers] #'ibuffer-list-buffers)
(customize-set-variable 'global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)
(global-display-line-numbers-mode +1)
(delete-selection-mode)
(setq-default indent-tabs-mode nil
              delete-old-versions t
              create-lockfiles nil
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

(defun my/org-new-line ()
  "..."
  (interactive)
  (org-end-of-line)
  (org-meta-return))

(with-eval-after-load 'org
  (message "org mode started")
  (custom-set-variables
   '(org-adapt-indentation 'headline-data)
   '(org-support-shift-select t)
   '(org-startup-indented t))
  (define-key org-mode-map (kbd "S-<return>") 'my/org-new-line)
  (define-key org-mode-map (kbd "M-RET") 'consult-buffer))

(with-eval-after-load 'ediff
  ;; add ediff configuration
  (set-face-attribute 'ediff-even-diff-A nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-B nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-C nil :inherit nil)
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-vertically)
  (setq ediff-diff-options "-w")
  (setq ediff-window-setup-function #'ediff-setup-windows-plain))

(defvar my/notes-path "")
(setq custom-file (expand-file-name (concat "~/.emacs.d/lisp/custom-" (system-name) ".el")))
(message "Custom file path: %s" custom-file)
(load custom-file)

(defun my/open-notes ()
  "Open file from the notes directory"
  (interactive)			
  (if (find-file (concat my/notes-path (completing-read "Find a note: " (delete "." (delete ".." (directory-files my/notes-path))))))
      (message "Opening note...")
    (message "Aborting")))

(defun indent-buffer ()
  (interactive)			
  (save-excursion		
    (indent-region (point-min) (point-max) nil)))

(defvar my/path-separator ":")
(when (eq system-type 'windows-nt)
  (setq my/path-separator ";"))

(add-hook 'after-init-hook
          (lambda ()
            (setenv "PATH" (concat (string-join exec-path my/path-separator) my/path-separator (getenv "PATH")))
            (require 'extra-lsp)))

(defun my/start-powershell ()
  "..."
  (interactive)
  (async-shell-command "powershell.exe"))
