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
(defvar my/font "Ubuntu Mono-10")

(require 'my-const)

(set-frame-font my/font nil t)

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

(require 'my-defun)
(require 'my-keys)

(straight-use-package 'use-package)
(use-package use-package
	:straight t
	:config
	(setq use-package-always-ensure t))

(use-package f
	:straight t)
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'anzu)
(use-package markdown-mode
	:straight t)
(use-package transpose-frame
	:straight t)
(use-package dired-single
	:straight t)
(use-package which-key
	:straight t)

(use-package vertico
  :demand t                             ; Otherwise won't get loaded immediately
  :straight (vertico :files (:defaults "extensions/*") ; Special recipe to load extensions conveniently
                     :includes (vertico-indexed
                                vertico-flat
                                vertico-grid
                                vertico-mouse
                                vertico-quick
                                vertico-buffer
                                vertico-repeat
                                vertico-reverse
                                vertico-directory
                                vertico-multiform
                                vertico-unobtrusive
                                ))
  :bind
  (:map vertico-map
        (("<tab>" . vertico-insert) ; Set manually otherwise setting `vertico-quick-insert' overrides this
         ("<escape>" . minibuffer-keyboard-quit)
         ("?" . minibuffer-completion-help)
         ("C-M-n" . vertico-next-group)
         ("C-M-p" . vertico-previous-group)
         ;; Multiform toggles
         ("<backspace>" . vertico-directory-delete-char)
         ("C-w" . vertico-directory-delete-word)
         ("C-<backspace>" . vertico-directory-delete-word)
         ("RET" . vertico-directory-enter)
         ("C-i" . vertico-quick-insert)
         ("C-o" . vertico-quick-exit)
         ("M-o" . kb/vertico-quick-embark)
         ("M-G" . vertico-multiform-grid)
         ("M-F" . vertico-multiform-flat)
         ("M-R" . vertico-multiform-reverse)
         ("M-U" . vertico-multiform-unobtrusive)
         ("C-l" . kb/vertico-multiform-flat-toggle)
         ))
  :hook ((rfn-eshadow-update-overlay . vertico-directory-tidy) ; Clean up file path when typing
         (minibuffer-setup . vertico-repeat-save) ; Make sure vertico state is saved
         )
  :custom
  (vertico-count 13)
  (vertico-resize t)
  (vertico-cycle t)
  ;; Extensions
  (vertico-grid-separator "       ")
  (vertico-grid-lookahead 50)
  (vertico-buffer-display-action '(display-buffer-reuse-window))
  (vertico-multiform-categories
   '((file reverse)
     (consult-grep buffer)
     (consult-location)
		 (consult-xref buffer)
     (imenu buffer)
     (library reverse indexed)
     (org-roam-node reverse indexed)
     (t reverse)
     ))
  (vertico-multiform-commands
   '(("flyspell-correct-*" grid flat)
     (org-refile grid flat indexed)
     (consult-yank-pop indexed)
     (consult-flycheck)
     (consult-lsp-diagnostics)
     ))
  :init
  (defun kb/vertico-multiform-flat-toggle ()
    "Toggle between flat and reverse."
    (interactive)
    (vertico-multiform--display-toggle 'vertico-flat-mode)
    (if vertico-flat-mode
        (vertico-multiform--temporary-mode 'vertico-reverse-mode -1)
      (vertico-multiform--temporary-mode 'vertico-reverse-mode 1)))
  (defun kb/vertico-quick-embark (&optional arg)
    "Embark on candidate using quick keys."
    (interactive)
    (when (vertico-quick-jump)
      (embark-act arg)))

  ;; Workaround for problem with `tramp' hostname completions. This overrides
  ;; the completion style specifically for remote files! See
  ;; https://github.com/minad/vertico#tramp-hostname-completion
  (defun kb/basic-remote-try-completion (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-try-completion string table pred point)))
  (defun kb/basic-remote-all-completions (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-all-completions string table pred point)))
  (add-to-list 'completion-styles-alist
               '(basic-remote           ; Name of `completion-style'
                 kb/basic-remote-try-completion kb/basic-remote-all-completions nil))
  :config
  (vertico-mode)
  ;; Extensions
  (vertico-multiform-mode)

  ;; Prefix the current candidate with “» ”. From
  ;; https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face 'vertico-current)
                   "  ")
                 cand)))
  )

(use-package back-button
	:straight t
	:ensure t
	:config
	(back-button-mode +1)
	(add-hook 'savehist-save-hook #'back-button-push-mark-local-and-global)
	:bind
	("M-i" . back-button-global)
	("M-S-i" . back-button-push-mark-local-and-global))

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

(use-package find-file-rg
	:straight (find-file-rg :type git :host github :repo "muffinmad/emacs-find-file-rg")
	:bind
	("M-s f" . find-file-rg))

(use-package easy-kill
	:straight t
	:config
	(global-set-key [remap kill-ring-save] 'easy-kill)
	(global-set-key [remap mark-sexp] 'easy-mark))

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

(use-package all-the-icons-completion
	:straight t
	:config
	(all-the-icons-completion-mode +1)
	(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package consult
	:straight t
	:bind
	("M-s s" . consult-ripgrep-symbol-at-point)
	("M-s g" . consult-ripgrep)
	("M-s M-g" . consult-git-grep)
	("M-S-i" . consult-global-mark)
	("M-s M-s" . consult-ripgrep-related-files)
	:config
	(custom-set-variables
	 '(xref-show-xrefs-function 'consult-xref))
	(consult-customize
	 ;; Disable preview for `consult-theme' completely.
	 ;; consult-theme :preview-key nil
	 ;; consult-buffer :preview-key nil
	 ;; consult-recent-file :preview-key nil
	 ;; consult-ripgrep :preview-key nil 
	 ;; consult-grep :preview-key nil 
	 ;; ;; Set preview for `consult-buffer' to key `M-.'
	 ;; consult-buffer :preview-key nil
	 ;; For `consult-line' change the prompt and specify multiple preview
	 ;; keybindings. Note that you should bind <S-up> and <S-down> in the
	 ;; `minibuffer-local-completion-map' or `vertico-map' to the commands which
	 ;; select the previous or next candidate.
	 consult-line :prompt "Search: ")
	(setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>") (kbd "M-i")))
	(defun consult-ripgrep-symbol-at-point ()
		"Seearch in files whose base name is the same as the current file's."
		(interactive)
		(back-button-push-mark-local-and-global)
		(minibuffer-with-setup-hook
				(lambda () (goto-char (1+ (minibuffer-prompt-end))))
			(consult-ripgrep (my/root-project-dir)
											 (if-let ((sap (symbol-at-point)))
													 (format "%s" sap)
												 (user-error "Buffer is not visiting a file")))))
	
	(defun consult-ripgrep-related-files ()
		"Seearch in files whose base name is the same as the current file's."
		(interactive)
		(back-button-push-mark-local-and-global)
		(minibuffer-with-setup-hook
				(lambda () (goto-char (1+ (minibuffer-prompt-end))))
			(consult-ripgrep (my/root-project-dir)
											 (if-let ((file (buffer-file-name)))
													 (format "%s -- -g %s*.*" (symbol-at-point) (file-name-base file))
												 (user-error "Buffer is not visiting a file")))))
	
	(defun restrict-to-current-file ()
		(interactive)
		(if-let ((file (with-minibuffer-selected-window
										 (buffer-file-name))))
				;; (message "file: %s" file)
				(save-excursion
					(goto-char (point-max))
					(insert " -- -g " (file-name-base file) "*.*"))
			(user-error "Buffer is not visiting a file"))))

(use-package embark
	:straight t
  :bind
  (("C-h e" . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
	(define-key embark-buffer-map (kbd "C-S-p") 'my/menu-base)
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
	:init
  (with-eval-after-load 'embark
    (require 'embark-consult))
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
	:straight t
	:config
	(setq corfu-cycle t
				corfu-quit-at-boundary nil
				corfu-auto t)
	(global-corfu-mode +1))

(use-package savehist
	:straight t
	:config
	(savehist-mode +1))

(use-package multiple-cursors
	:straight t)

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
	(setq cape-dabbrev-min-length 2)
	:bind
	("C-/" . cape-dabbrev))

(use-package kind-icon
	:straight '(kind-icon
							:type git
							:repo "jdtsmith/kind-icon")
	:config
	(setq kind-icon-default-face 'corfu-default)
	(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package project
	:straight t
	:init
	(defun my/root-project-dir ()
		(if-let ((project (project-current)))
				(car (project-roots project))
			(format "%s" default-directory)))
	:config
	(setq consult-project-root-function #'my/root-project-dir))

(marginalia-mode +1)
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
 custom-file (concat user-emacs-directory "custom.new.el")
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
 ;; corfu-cycle t
 isearch-allow-scroll t
 scroll-preserve-screen-position t
 isearch-allow-prefix t
 linum-format "%3s"
 ls-lisp-dirs-first t
 ls-lisp-use-insert-directory-program nil
 mark-ring-max 32)

;; dired
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
   loaded."
	(define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)
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

(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)

;; add exec-path
(mapcar (lambda (cdir)
					(add-to-list 'exec-path cdir)) my/exec-dir)
(mapcar (lambda (cdir)
					(setenv "PATH" (concat cdir ":" (getenv "PATH")))) my/exec-dir)

(winner-mode +1)
(with-eval-after-load 'ediff
	;; add ediff configuration
	(set-face-attribute 'ediff-even-diff-A nil :inherit nil)
	(set-face-attribute 'ediff-even-diff-B nil :inherit nil)
	(set-face-attribute 'ediff-even-diff-C nil :inherit nil)
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

(use-package org
	:straight t
	:defer t
	:config
	(add-hook 'org-mode-hook 'org-modern-mode)
	(define-key org-mode-map [mouse-1] 'org-cycle)
	(setq org-todo-keywords
				'((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "|" "DONE" "DELEGATED" "CANCELED"))
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
   '(org-hide-leading-stars t)))

(use-package org-modern
	:straight t
	:defer t)

(use-package emacs
	:config
	(when (file-exists-p custom-file)
		(load custom-file))
	(global-unset-key (kbd "C-x C-b"))
	(global-unset-key (kbd "C-x b"))
	(global-unset-key (kbd "M-j"))
	(global-set-key (kbd "C-x b") 'switch-to-buffer)
	(global-set-key (kbd "<C-tab>") 'consult-buffer)
	(global-set-key (kbd "M-j") 'consult-buffer)
	(global-set-key (kbd "<C-M-left>") 'rotate-frame)
	(global-set-key (kbd "<M-S-left>") 'windmove-swap-states-left)
	(global-set-key (kbd "<M-right>") 'other-window)
	(global-set-key (kbd "<M-S-right>") 'windmove-swap-states-right)
	(global-set-key (kbd "C-.") 'repeat-complex-command)
	(global-set-key (kbd "M-C-o") 'consult-recent-file)
	(global-set-key (kbd "C-S-f") 'consult-line)
	(global-set-key (kbd "M-s C-SPC") 'my/xah-select-line)
	(global-unset-key (kbd "C-o"))
	(global-unset-key (kbd "M-o"))
	(global-set-key (kbd "C-o") 'project-find-file)
	(global-set-key (kbd "M-o") 'project-find-file)
	(global-unset-key (kbd "M-k"))
	(define-prefix-command 'my-emacs-prefix)
	(global-set-key (kbd "M-k") 'my-emacs-prefix)
	(define-key 'my-emacs-prefix (kbd "k") 'kill-sentence)
	(define-key 'my-emacs-prefix (kbd "p") 'kill-paragraph)
	(define-key 'my-emacs-prefix (kbd "o") 'delete-other-windows)
	(define-key 'my-emacs-prefix (kbd "l") 'kill-line)
	(setq standard-indent 2)
	(save-place-mode +1)
	(setq use-dialog-box nil)
	(setq global-auto-revert-non-file-buffers t)
	(global-auto-revert-mode 1)
	(global-visual-line-mode t)
	(global-hi-lock-mode 1)
	(pixel-scroll-precision-mode +1)
	(with-eval-after-load 'ediff
		(set-face-attribute 'ediff-even-diff-A nil :inherit nil)
		(set-face-attribute 'ediff-even-diff-B nil :inherit nil)
		(set-face-attribute 'ediff-even-diff-C nil :inherit nil))
	:bind
	(:map minibuffer-mode-map
				("M-e" . embark-act)
				("<C-tab>" . previous-line)
				("M-j" . previous-line)
				("M-l" . next-line)
				("M-k" . exit-minibuffer)
				("C-q" . exit-minibuffer)))

(use-package recentf
	:straight t
	:config
	(recentf-mode))

(cd my/base-dir)

(blink-cursor-mode 0)

(my/end-of-init)

(use-package undo-tree
	:straight t
	:defer t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (undo-tree-visualizer-timestamps t))

(use-package crux
	:straight t
	:bind
	("<C-S-return>" . crux-smart-open-line-above)
	("<S-return>" . 'crux-smart-open-line)
	("C-k" . 'crux-smart-kill-line))

(use-package git-timemachine
	:straight t)

(use-package doom-modeline
	:straight t
	:config
	(column-number-mode +1)
	(size-indication-mode +1)
	(setq doom-modeline-lsp t)
	(setq doom-modeline-workspace-name t)
	(setq doom-modeline-vcs-max-length 24)
	(setq doom-modeline-checker-simple-format t)
	(setq doom-modeline-indent-info nil)
	(setq doom-modeline-buffer-encoding t)
	(setq doom-modeline-enable-word-count t)
	(setq doom-modeline-buffer-name t)
	(setq doom-modeline-buffer-modification-icon t)
	(setq doom-modeline-major-mode-color-icon t)
	(setq doom-modeline-major-mode-icon t)
	(setq doom-modeline-buffer-file-name-style 'auto)
	(setq doom-modeline-project-detection 'auto)
	(setq doom-modeline-height 30)
	:init
	(doom-modeline-mode 1))

(use-package json-mode
	:straight t
  :ensure t)

(use-package popwin
	:straight t
	:config
	(popwin-mode 1))

(use-package centaur-tabs
	:straight t
	:config
	(defun centaur-tabs-hide-tab (x)
		"Do no to show buffer X in tabs."
		(let ((name (format "%s" x)))
			(or
			 ;; Buffer name not match below blacklist.
			 (string-prefix-p "*epc" name)
			 (string-prefix-p "*helm" name)
			 (string-prefix-p "*Helm" name)
			 (string-prefix-p "*Compile-Log*" name)
			 (string-prefix-p "*lsp" name)
			 (string-prefix-p "*company" name)
			 (string-prefix-p "*Flycheck" name)
			 (string-prefix-p "*tramp" name)
			 (string-prefix-p " *Mini" name)
			 (string-prefix-p "*help" name)
			 (string-prefix-p "*straight" name)
			 (string-prefix-p " *temp" name)
			 (string-prefix-p "*Help" name)
			 (string-prefix-p "*mybuf" name)
			 (string-prefix-p "*Calc" name)

			 ;; Is not magit buffer.
			 (and (string-prefix-p "magit" name)
						(not (file-name-extension name)))
			 )))
	(defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
		 (cond
			((and (string-equal "*" (substring (buffer-name) 0 1))
						(not (string-equal "*scratch*" (buffer-name))))
			 "Emacs")
			((or (not (string-equal "*" (substring (buffer-name) 0 1)))
					 (string-equal "*scratch*" (buffer-name)))
			 "All")
			(t
			 (centaur-tabs-get-group-name (current-buffer))))))
	(centaur-tabs-mode))

(use-package remember-last-theme
	:straight t)

(use-package solo-jazz-theme
	:straight t)

(remember-last-theme-with-file-enable "~/.emacs.d/last-theme")

(my/start/devenv)
