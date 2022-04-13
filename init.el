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
(straight-use-package 'dired-single)
(straight-use-package 'which-key)
(straight-use-package 'el-get)

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
     (imenu buffer)
     (library reverse indexed)
     (org-roam-node reverse indexed)
     (t reverse)
     ))
  (vertico-multiform-commands
   '(("flyspell-correct-*" grid reverse)
     (org-refile grid reverse indexed)
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
	:config
	(back-button-mode +1)
	(add-hook 'savehist-save-hook #'back-button-push-mark-local-and-global)
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
  (("C-;" . embark-act)         ;; pick some comfortable binding
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
	;; (defun my/dabbrev-select-buffer ()
	;; 	"T."
	;; 	(let ((bl (buffer-list))
	;; 				(result '()))
	;; 		(while bl
	;; 			(message "%s" (car bl))
	;; 			(when (buffer-file-name (car bl))
	;; 				(add-to-list 'result (car bl)))
	;; 			(setq bl (cdr bl)))
	;; 		result))

	;; (setq dabbrev-friend-buffer-function #'my/dabbrev-select-buffer)
	;; (setq dabbrev-select-buffers-function #'my/dabbrev-select-buffer)
	;; (setq dabbrev-case-fold-search nil
	;; 			dabbrev-case-replace nil)
	:bind
	("C-/" . cape-dabbrev))


(straight-use-package '(kind-icon
												:type git
												:repo "jdtsmith/kind-icon"))
(require 'kind-icon)
(setq kind-icon-default-face 'corfu-default)
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)

(with-eval-after-load 'project
	(setq consult-project-root-function #'my/root-project-dir))

(defun my/root-project-dir ()
	(if-let ((project (project-current)))
			(car (project-roots project))
		(format "%s" default-directory)))

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

(add-hook 'nxml-mode-hook 'my/long-line)
(add-hook 'json-mode-hook 'my/long-line)
(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)

;; add exec-path
(mapcar (lambda (cdir)
					(add-to-list 'exec-path cdir)) my/exec-dir)
(mapcar (lambda (cdir)
					(setenv "PATH" (concat cdir ":" (getenv "PATH")))) my/exec-dir)

;; (setq find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
;; (add-hook 'dired-mode-hook 'dired-hide-details-mode)

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
(with-eval-after-load 'org-mode
	(progn
		(define-key org-mode-map [mouse-1] 'org-cycle)
		(straight-use-package 'org-superstar)
		(straight-use-package 'org-bullets)
		(add-hook 'org-mode-hook (lambda ()
															 (define-key org-mode-map (kbd "<C-tab>") 'my/select-window)
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
	(when (file-exists-p custom-file)
		(load custom-file))
	(global-unset-key (kbd "C-x C-b"))
	(global-unset-key (kbd "C-x b"))
	(global-set-key (kbd "<C-tab>") 'my/switch-to-buffer)
	(global-set-key (kbd "C-x b") 'switch-to-buffer)
	(global-set-key (kbd "<M-left>") 'windmove-left)
	(global-set-key (kbd "<M-S-left>") 'windmove-swap-states-left)
	(global-set-key (kbd "<M-right>") 'windmove-right)
	(global-set-key (kbd "<M-S-right>") 'windmove-swap-states-right)
	(global-set-key (kbd "C-.") 'repeat-complex-command)
	(global-set-key (kbd "M-C-o") 'consult-recent-file)
	(global-set-key (kbd "C-s") 'consult-line)
	(global-unset-key (kbd "C-S-o"))
	(global-set-key (kbd "C-S-o") 'find-file)
	(global-unset-key (kbd "C-o"))
	(global-set-key (kbd "C-o") 'project-find-file)
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
	(pixel-scroll-precision-mode +1)
	:bind
	(:map minibuffer-mode-map
				("<C-tab>" . previous-line)))

(use-package recentf
	:straight t
	:config
	(recentf-mode))

(cd my/base-dir)

(blink-cursor-mode 0)
(setq cursor-type 'bar)

(my/end-of-init)

(use-package magit
	:straight t
	:commands (magit-status)
	:init

	(defun my/magit-status ()
		"Open a magit directory."
		(interactive)
		(let ((current-prefix-arg '(4)))
			(call-interactively #'magit-status)
			(delete-other-windows)))

	(defun my/goto-magit ()
		"T."
		(interactive)
		(require 'consult)
		(let* ((buffers (buffer-list))
					 (projroot (my/root-project-dir))
					 (projname (consult--project-name projroot))
					 (magitbuffer nil)
					 (projbuffername (concat "magit: " projname)))
			(while buffers
				(when (string-equal (buffer-name (car buffers)) projbuffername)
					(setq magitbuffer (car buffers))
					(setq buffers nil))
				(setq buffers (cdr buffers))
				(message "%s" magitbuffer)
				)
			(if magitbuffer
					(switch-to-buffer magitbuffer)
				(my/magit-status))
			)
		)
	:config
	(add-hook 'magit-status-mode-hook (lambda ()
																			(remove-hook 'magit-diff-sections-hook 'magit-insert-xref-buttons)
																			(remove-hook 'magit-revision-sections-hook 'magit-insert-xref-buttons)
																			(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-headers)
																			(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-notes)
																			(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-tag)
																			(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-message)
																			(remove-hook 'magit-section-highlight-hook 'magit-diff-highlight)
																			(remove-hook 'magit-section-movement-hook 'magit-log-maybe-update-revision-buffer)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-rest)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-output)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-log)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-error-header)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-upstream-branch-header)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
																			(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
																			(setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11))
																			(setq magit--default-directory my/project-dir)  
																			(setq magit-section-initial-visibility-alist (quote ((untracked . hide) (stashes . hide))))
																			(define-key magit-stash-mode-map (kbd "a") (lambda ()
																																									 (magit-stash-apply)
																																									 (magit-log-bury-buffer)
																																									 (magit-refresh)))
																			(define-key magit-mode-map (kbd "<C-tab>") 'my/switch-to-buffer)
																			(define-key magit-status-mode-map (kbd "<C-tab>") 'my/switch-to-buffer)
																			(define-key magit-log-mode-map (kbd "<C-tab>") 'my/switch-to-buffer)
																			(define-key magit-revision-mode-map (kbd "<C-tab>") 'my/switch-to-buffer)))
	(custom-set-faces 
	 '(magit-diff-hunk-heading ((t (:foreground "orange"))))))

(use-package undo-fu
	:straight t
	:bind
	("C-z" . undo-fu-only-undo)
	("C-y" . undo-fu-only-redo))

(use-package crux
	:straight t
	:bind
	("<C-S-return>" . crux-smart-open-line-above)
	("<S-return>" . 'crux-smart-open-line)
	("C-k" . 'crux-smart-kill-line))

(use-package ibuffer-sidebar
	:straight t
	:commands (ibuffer-sidebar-toggle-sidebar)
	:bind
	(("C-x C-b" . ibuffer-sidebar-toggle-sidebar)
	 (:map my-prefix
				 ("c b" . ibuffer-sidebar-toggle-sidebar)))
	:config
	(setq ibuffer-sidebar-use-custom-font t))

(use-package command-frequency
	:straight t
	:config
	(command-frequency-mode +1)
	(command-frequency-autosave-mode +1))

(use-package git-timemachine
	:straight t)

(use-package remember-last-theme
	:straight t)

(use-package doom-modeline
	:straight t
	:config
	(setq doom-modeline-lsp t)
	(setq doom-modeline-workspace-name t)
	(setq doom-modeline-vcs-max-length 12)
	(setq doom-modeline-checker-simple-format t)
	(setq doom-modeline-indent-info nil)
	(setq doom-modeline-buffer-encoding t)
	;; (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
	(setq doom-modeline-enable-word-count t)
	(setq doom-modeline-buffer-name t)
	(setq doom-modeline-buffer-modification-icon t)
	(setq doom-modeline-major-mode-color-icon t)
	(setq doom-modeline-major-mode-icon t)
	(setq doom-modeline-buffer-file-name-style 'auto)
	(setq doom-modeline-project-detection 'auto)
	(setq doom-modeline-height 25)
	:init
	(doom-modeline-mode 1))

(use-package doom-themes
	:straight t
	:config (progn (remember-last-theme-with-file-enable "~/.emacs.d/last-theme")))

(use-package highlight-current-line
	:straight t
	:config
	(global-hl-line-mode -1)
	(custom-set-variables
	 '(highlight-current-line-whole-line nil)
	 '(highlight-current-line-globally t nil (highlight-current-line)))
	(custom-set-faces
	 '(highlight-current-line-face ((t (:box (:line-width (1 . 1) :color "grey75" :style flat-button))))))
	(highlight-current-line-minor-mode))
