;; -*- lexical-binding: t -*-

(defalias 'yes-or-no-p 'y-or-n-p)
;; (cua-mode +1)
(use-package diminish)

(use-package orderless
  :demand t)

(use-package marginalia
	:demand t
	:init
	(marginalia-mode +1))

(use-package anzu
	:demand t
	:init
	(global-anzu-mode +1)
	:config
	(diminish 'anzu-mode))

(use-package vertico
	:init
	(vertico-mode +1)
	:custom
	(vertico-count 13)
  (vertico-resize t)
  (vertico-cycle t))

(require 'my-backward-forward)
(add-hook 'savehist-save-hook #'backward-forward-push-mark-wrapper)
(backward-forward-mode +1)

(use-package move-text
  :demand t
  :config
  (move-text-default-bindings))

(use-package dired-single)

(use-package which-key
	:init
	(which-key-mode +1)
	(diminish 'which-key-mode))

(use-package all-the-icons-completion
  :demand t
  :config
  (all-the-icons-completion-mode +1)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package consult
  :bind
  ("M-s s" . consult-ripgrep-symbol-at-point)
  ("M-s g" . consult-ripgrep)
	("M-s S-n" . consult-ripgrep-search-in-notes)
	("M-s M-n" . consult-ripgrep-search-in-temp-dir)
  ("M-s M-g" . consult-git-grep)
  ("M-s M-s" . consult-ripgrep-related-files)
  :config
	(defvar consult--source-my-menu
		`(:name     "My MENU"
								:narrow   ?f
								:category 'function
								:face     'font-lock-keyword-face
								:default  t
								:action (lambda (result) (call-interactively (cdr (assoc result my/menu-items))))
								:items (lambda () (mapcar #'car my/menu-items)))
		"My menu items for `consult-buffer'.")
	
  (custom-set-variables
	 '(consult-buffer-sources
     '(consult--source-hidden-buffer consult--source-modified-buffer consult--source-buffer consult--source-project-buffer consult--source-project-recent-file consult--source-recent-file consult--source-bookmark consult--source-my-menu))
   '(xref-show-xrefs-function 'consult-xref))
  (consult-customize
   consult-line :prompt "Search: ")
  (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>") (kbd "M-i")))
  (defun consult-ripgrep-symbol-at-point ()
    "Seearch in files whose base name is the same as the current file's."
    (interactive)
    (minibuffer-with-setup-hook
        (lambda () (goto-char (1+ (minibuffer-prompt-end))))
      (consult-ripgrep (my/root-project-dir)
                       (if-let ((sap (symbol-at-point)))
                           (format "%s -- -g *" sap)
                         (user-error "Buffer is not visiting a file")))))
  (defun consult-ripgrep-related-files ()
    "Seearch in files whose base name is the same as the current file's."
    (interactive)
    (minibuffer-with-setup-hook
        (lambda () (goto-char (1+ (minibuffer-prompt-end))))
      (consult-ripgrep (my/root-project-dir)
                       (if-let ((file (buffer-file-name)))
                           (format "%s -- -g %s*.*" (symbol-at-point) (file-name-base file))
                         (user-error "Buffer is not visiting a file")))))
	(defun consult-ripgrep-files-in-directory (dir)
    "Seearch in files whose base name is the same as the current file's."
    (interactive "DDirectory: ")
    (minibuffer-with-setup-hook
        (lambda () (goto-char (1+ (minibuffer-prompt-end))))
      (consult-ripgrep dir " -- -g *.*")))
	(defun consult-ripgrep-search-in-notes ()
		"Search in notes"
		(interactive)
		(consult-ripgrep-files-in-directory my/notes-dir))
	(defun consult-ripgrep-search-in-temp-dir ()
		"Search in temp notes"
		(interactive)
		(consult-ripgrep-files-in-directory my/temp-dir))
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
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
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
  :demand t
  :config
  (setq corfu-cycle nil
        corfu-quit-at-boundary nil
        corfu-auto-prefix 2
        corfu-auto nil
        corfu-quit-no-match t)
  (global-corfu-mode +1))

(use-package corfu-doc
  :init
  (add-to-list 'corfu-mode-hook #'corfu-doc-mode))

(use-package savehist
	:straight (:type built-in)
  :demand t
  :config
  (savehist-mode +1))

(use-package cape
  :demand t
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
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-keyword)
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
  :init
  (defun my/root-project-dir ()
    (if-let ((project (project-current)))
        (car (project-roots project))
      (format "%s" default-directory)))
  :config
  (setq consult-project-root-function #'my/root-project-dir))

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

(use-package winner
	:init
	(winner-mode +1))

(with-eval-after-load 'ediff
  ;; add ediff configuration
  (set-face-attribute 'ediff-even-diff-A nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-B nil :inherit nil)
  (set-face-attribute 'ediff-even-diff-C nil :inherit nil)
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-vertically)
  (setq ediff-diff-options "-w")
  (setq ediff-window-setup-function #'ediff-setup-windows-plain))

(add-hook 'so-long-mode-hook (lambda ()
                               (require 'longlines)
                               (longlines-mode)))

(require 'frontside-windowing)
(frontside-windowing-mode +1)

(use-package emacs
  :config
  (setq standard-indent 2)
  (save-place-mode +1)
	(setq-default auto-save-interval 30)
  (setq use-dialog-box nil)
  (setq global-auto-revert-non-file-buffers t)
	(setq-default header-line-format "")
	(set-fringe-mode 10)
  (global-auto-revert-mode 1)
  (global-hi-lock-mode 1)
  (pixel-scroll-precision-mode +1)
	(setq current-language-environment "UTF-8")
	(prefer-coding-system 'utf-8)
	(blink-cursor-mode 0)
	(global-visual-line-mode t)
	(set-default-coding-systems 'utf-8)
	(set-language-environment 'utf-8)
	(set-selection-coding-system 'utf-8)
  (setq indent-tabs-mode nil)
	
  (with-eval-after-load 'ediff
    (set-face-attribute 'ediff-even-diff-A nil :inherit nil)
    (set-face-attribute 'ediff-even-diff-B nil :inherit nil)
    (set-face-attribute 'ediff-even-diff-C nil :inherit nil))

  (add-to-list 'auto-mode-alist '("\\.dtsx\\'" . fundamental-mode))
  :bind
	(("<C-tab>" . other-window)
   (:map minibuffer-mode-map
         ("M-m" . embark-act)))
  :delight
  (auto-fill-function " AF")
  (visual-line-mode))

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

;; (use-package ctrlf
;;   :demand t
;;   :config
;;   (ctrlf-mode +1))

(use-package visual-regexp
	:bind
	("M-r" . vr/replace))

(global-hl-line-mode t)

(use-package popper
  :bind* ("C-c :" . popper-toggle-latest)
  :bind (("C-`"   . popper-toggle-latest)
         ("C-\\"  . popper-cycle)
         ("M-\\"  . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :hook (prog-mode . popper-mode)
  :config
  (popper-mode +1)
  (popper-echo-mode +1)
  :custom
  (popper-window-height 24)
  (popper-reference-buffers '("\\*Messages\\*"
                              "Output\\*$"
                              "\\*Async Shell Command\\*"
															".*Embark Collect.*"
                              "\\*compilation\\*"
                              help-mode
                              "\\*eldoc.\*"
                              "\\*shell\\*"
                              "\\*eshell\\*"
                              "\\*xref\\*"
                              "\\*org-roam\\*"
                              "\\*direnv\\*"
                              "\\*Warnings\\*"
                              "\\*Bookmark List\\*"
                              haskell-compilation-mode
                              compilation-mode)))

(provide 'my-core)
