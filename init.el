;; -*- lexical-binding: t -*-

;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; ;; and `package-pinned-packages`. Most users will not need or want to do this.
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; (message "%s" file-name-handler-alist)
;; (setq debug-on-error t)

(defalias 'yes-or-no-p 'y-or-n-p)

(let ((my-load-file
       (expand-file-name (concat user-emacs-directory "progs"))))
  (add-to-list 'load-path my-load-file))

;; the ide mode enabled or not
(defvar my/dev-env nil)
;; the ide mode hook
(defvar my/dev-hook '())

(require 'my-const)

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

(setq straight-check-for-modifications nil)

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

(load (expand-file-name (concat user-emacs-directory "custom.el")))
(require 'my-defun)
(require 'my-keys)
;; (require 'my-layout)

(straight-use-package 'use-package)
(use-package use-package
	:config
	(setq use-package-always-ensure t))

(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'undo-tree)
(straight-use-package 'anzu)
(straight-use-package 'markdown-mode)
(straight-use-package 'transpose-frame)
(straight-use-package 'git-timemachine)
(straight-use-package 'dired-single)
(straight-use-package 'which-key)
(straight-use-package 'el-get)

(use-package vertico
	:straight t
	:config
	(setq vertico-cycle t)
	(vertico-mode +1))

(use-package mini-popup
	:straight t
	:config
	(progn
		(mini-popup-mode +1)
		(defun mini-popup-height-resize ()
			(* (1+ (min vertico--total vertico-count)) (default-line-height)))
		(defun mini-popup-height-fixed ()
			(* (1+ (if vertico--input vertico-count 0)) (default-line-height)))
		(setq mini-popup--height-function #'mini-popup-height-fixed)

		;; Disable the minibuffer resizing of Vertico (HACK)
		(advice-add #'vertico--resize-window :around
								(lambda (&rest args)
									(unless mini-popup-mode
										(apply args))))

		;; Ensure that the popup is updated after refresh (Consult-specific)
		(add-hook 'consult--completion-refresh-hook
							(lambda (&rest _) (mini-popup--setup)) 99)))

(use-package back-button
	:straight t
	:config
	(back-button-mode +1)
	:bind
	("M-i" . back-button-global)
	("C-i" . back-button-push-mark-local-and-global))

(use-package recentf
	:defer t)

(use-package move-text
	:straight t
	:config
	(move-text-default-bindings))

(use-package visual-regexp
	:straight t
	:bind
	("M-r" . vr/replace))

(use-package wgrep
	:straight t)

(use-package use-package
	:straight t
	:config
	(setq use-package-ensure t))

;; (use-package affe
;; 	:straight t
;; 	:bind
;; 	("M-s s" . affe-grep)
;; 	;; ("M-s f" . affe-find)
;; 	:config
;; 	(progn 
;; 		(setq invocation-name "runemacs.exe")
;; 		(defun affe-orderless-regexp-compiler (input _type)
;; 			(setq input (orderless-pattern-compiler input))
;; 			(cons input (lambda (str) (orderless--highlight input str))))
;; 		(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)))

(use-package find-file-rg
	:straight (find-file-rg :type git :host github :repo "muffinmad/emacs-find-file-rg")
	:bind
	("M-s f" . find-file-rg))

(use-package easy-kill
	:straight t
	:config
	(global-set-key [remap kill-ring-save] 'easy-kill))

(use-package rg
	:straight t
  :init
	(defun my/project/rg ()
		"T."
		(interactive)
		(let ((currProject (project-current)))
			(if currProject
					(call-interactively 'rg-project)
				(call-interactively 'rg))))
	:bind
	("M-s r" . my/project/rg))

(use-package consult
	:straight t
	:bind
	("M-s s" . consult-ripgrep)
	("M-s g" . consult-git-grep)
	("M-S-i" . consult-global-mark))

(use-package embark
	:straight t
  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("C-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
								 (display-buffer-reuse-window display-buffer-in-side-window)
								 (window-height . 0.20)
								 (side . left)
								 (slot . 4)
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
	:straight t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
	:straight t
	:config
	(setq corfu-cycle t)
	(corfu-global-mode +1))

(use-package savehist
	:straight t
	:config
	(savehist-mode +1))

(use-package cape
	:straight (cape :type git :host github :repo "minad/cape")
	:init
	(defun my/ignore-elisp-keywords (cand)
		(or (not (keywordp cand))
				(eq (char-after (car completion-in-region--data)) ?:)))

	(defun my/setup-elisp ()
		(setq-local completion-at-point-functions
								'(elisp-completion-at-point
									cape-dabbrev
									cape-file)
								cape-dabbrev-min-length 2))
	:config
	(setq completion-at-point-functions '(cape-line))
	(add-to-list 'completion-at-point-functions #'cape-symbol)
	(add-to-list 'completion-at-point-functions #'cape-keyword)
	(add-to-list 'completion-at-point-functions #'cape-dabbrev)
	(add-to-list 'completion-at-point-functions #'cape-file)
	(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)
	:bind
	("M-/" . cape-dabbrev))


(straight-use-package '(kind-icon
												:type git
												:repo "jdtsmith/kind-icon"))
(require 'kind-icon)
(setq kind-icon-default-face 'corfu-default)
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)

(with-eval-after-load 'project
	(setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project))))))
(marginalia-mode +1)
;; (mini-frame-mode +1)
(global-undo-tree-mode +1)
(diminish 'undo-tree-mode)
(diminish 'anzu-mode)
(global-anzu-mode +1)
(show-paren-mode +1)
(cua-mode +1)
(which-key-mode +1)
(diminish 'which-key-mode)

(require 'dabbrev)
;; set defaults
(setq-default
 dired-dwim-target t
 doom-modeline-height 25
 autoload-compute-prefixes nil
 frame-inhibit-implied-resize t
 initial-major-mode 'fundamental-mode
 find-file-visit-truename nil
 ffap-machine-p-known 'accept     ; don't ping things that look like domain names
 idle-update-delay 1              ; update ui slightly less often
 ;; History & backup settings (save nothing, that's what git is for)
 auto-save-default nil
 create-lockfiles nil
 history-length 500
 make-backup-files nil  ; don't create backup~ files
 package-check-signature nil
 custom-file (concat user-emacs-directory "custom.el")
 inhibit-startup-screen t
 tab-width 2
 split-height-threshold 0
 split-width-threshold nil
 bidi-paragraph-direction 'left-to-right
 bidi-display-reordering nil
 gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
 browse-url-browser-function 'browse-url-generic
 set-mark-command-repeat-pop t
 resize-mini-windows t
 completion-styles '(orderless)
 completion-category-defaults nil
 completion-category-overrides '((file (styles . (partial-completion))))
 completion-cycle-threshold 3
 tab-always-indent 'complete
 corfu-cycle t
 isearch-allow-scroll t
 scroll-preserve-screen-position t
 isearch-allow-prefix t
 linum-format "%3s"
 mark-ring-max 32)

;; dired
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
   loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [remap dired-find-file]
							'dired-single-buffer)
  (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
							'dired-single-buffer-mouse)
  (define-key dired-mode-map [remap dired-up-directory]
							'dired-single-up-directory))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
    ;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
  (add-hook 'dired-load-hook 'my-dired-init))

;; Better scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(set-window-scroll-bars (minibuffer-window) nil nil)

;; do not split window
(setq split-width-threshold (- (window-width) 10))
(setq split-height-threshold nil)

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer

(add-hook 'nxml-mode-hook 'my/long-line)
(add-hook 'json-mode-hook 'my/long-line)
(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)

;; add exec-path
(mapcar (lambda (cdir)
					(add-to-list 'exec-path cdir)) my/exec-dir)
(mapcar (lambda (cdir)
					(setenv "PATH" (concat cdir ":" (getenv "PATH")))) my/exec-dir)

(setq find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(winner-mode +1)
(with-eval-after-load 'ediff
	;; add ediff configuration
	(setq ediff-split-window-function 'split-window-horizontally)
	(setq ediff-merge-split-window-function 'split-window-vertically)
	(setq ediff-diff-options "-w")
	(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
	(setq ediff-window-setup-function #'ediff-setup-windows-plain))

(add-hook 'so-long-mode-hook (lambda ()
															 (require 'longlines)
															 (longlines-mode)))

(require 'frontside-windowing)
(frontside-windowing-mode +1)
(eval-after-load 'org-mode
	(progn
		(straight-use-package 'org-superstar)
		(straight-use-package 'org-bullets)
		(add-hook 'org-mode-hook (lambda ()
															 (org-bullets-mode +1)
															 (org-superstar-mode +1)))
		(setq org-todo-keywords
					'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "FAILED"))
					org-support-shift-select t
					org-log-done t)
		(custom-set-faces
		 '(org-level-1 ((t (:inherit outline-1 :height 1.5 :box nil))))
		 '(org-level-2 ((t (:inherit outline-2 :height 1.3 :box nil))))
		 '(org-level-3 ((t (:inherit outline-3 :height 1.2 :box nil))))
		 '(org-level-4 ((t (:inherit outline-4 :height 1.1 :box nil))))
		 '(org-level-5 ((t (:inherit outline-5 :height 1.0 :box nil))))
		 '(org-fontify-done-headline nil)
     '(org-fontify-todo-headline t)
     '(org-fontify-whole-heading-line t)
     '(org-hide-leading-stars t))))

(use-package emacs
	:config
	(global-unset-key (kbd "C-x C-b"))
	(global-unset-key (kbd "C-x b"))
	(global-set-key (kbd "M-l") 'my/switch-to-buffer)
	(global-set-key (kbd "C-x b") 'switch-to-buffer)
	(global-set-key (kbd "<M-left>") 'windmove-left)
	(global-set-key (kbd "<M-right>") 'windmove-right)
	(global-unset-key (kbd "M-p"))
	(global-set-key (kbd "M-p") 'my/switch-to-buffer)
	(global-unset-key (kbd "C-S-o"))
	(global-set-key (kbd "C-S-o") 'find-file)
	(global-unset-key (kbd "C-o"))
	(global-set-key (kbd "C-o") 'project-find-file)
	(global-unset-key (kbd "M-k"))
	(define-prefix-command 'my-emacs-prefix)
	(global-set-key (kbd "M-k") 'my-emacs-prefix)
	(define-key 'my-emacs-prefix (kbd "k") 'kill-sentence)
	(define-key 'my-emacs-prefix (kbd "p") 'kill-paragraph)
	(define-key 'my-emacs-prefix (kbd "l") 'kill-line)
	(setq standard-indent 2)
	(save-place-mode +1)
	(setq use-dialog-box nil)
	(setq global-auto-revert-non-file-buffers t)
	(global-auto-revert-mode 1)
	(global-visual-line-mode t)
	:bind
	(:map minibuffer-mode-map
				("M-l" . next-line)))

(use-package recentf
	:straight t
	:config
	(recentf-mode))

(cd my/base-dir)

(blink-cursor-mode 0)

(my/end-of-init)

(straight-use-package 'one-themes)
(use-package remember-last-theme
	:straight t
	;; :hook
	;; (kill-emacs-hook . remember-theme-save)
	:config (progn (remember-last-theme-with-file-enable "~/.emacs.d/last-theme")))

(use-package dumb-jump
	:straight t
	:bind
	("M-s d" . dumb-jump-go)
	:hook
	(xref-backend-functions . dumb-jump-xref-activate)
	:config
	(custom-set-variables
	 '(dumb-jump-max-find-time 5)
	 '(dumb-jump-selector 'completing-read)
	 '(dumb-jump-preferred-searcher 'rg))
	(setq xref-show-definitions-function #'xref-show-definitions-completing-read))
