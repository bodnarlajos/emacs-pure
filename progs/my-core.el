;; -*- lexical-binding: t -*-

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package diminish)
(use-package orderless
  :demand t)
(use-package marginalia
	:demand t)
(use-package anzu
	:demand t)

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
         ("M-m" . kb/vertico-quick-embark)
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
  (vertico-resize nil)
	(vertico--resize-window 13)
  (vertico-cycle nil)
  ;; Extensions
  (vertico-grid-separator "       ")
  (vertico-grid-lookahead 50)
  (vertico-buffer-display-action '(display-buffer-reuse-window))
  (vertico-multiform-categories
   '((consult-grep buffer)
     (consult-location buffer)
     (consult-xref buffer)
     (imenu buffer)
     ;; (library reverse indexed)
     ;; (org-roam-node reverse indexed)
     (t)
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
	(setq completion-in-region-function #'consult-completion-in-region)
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

(require 'my-backward-forward)
(add-hook 'savehist-save-hook #'backward-forward-push-mark-wrapper)
(backward-forward-mode +1)

(use-package move-text
  :demand t
  :config
  (move-text-default-bindings))

(use-package transpose-frame)
(use-package dired-single)
(use-package which-key)

(use-package easy-kill
  :demand t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(defun my/show-all ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-show-all))
	(when (bound-and-true-p hs-minor-mode)
		(hs-show-all)))

(defun my/hide-all ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-hide-body))
	(when (bound-and-true-p hs-minor-mode)
		(hs-hide-all)))

(defun my/hide-entry ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-hide-entry))
	(when (bound-and-true-p hs-minor-mode)
		(hs-hide-block)))

(defun my/show-entry ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-show-entry))
	(when (bound-and-true-p hs-minor-mode)
		(hs-show-block)))

(use-package all-the-icons-completion
  :demand t
  :config
  (all-the-icons-completion-mode +1)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package consult
  :bind
  ("M-s s" . consult-ripgrep-symbol-at-point)
  ("M-s g" . consult-ripgrep)
  ("M-s M-g" . consult-git-grep)
  ("M-s M-s" . consult-ripgrep-related-files)
  :config
	(defvar consult--source-my-menu
		`(:name     "My MENU"
								:narrow   ?b
								:category 'menu
								:face     'font-lock-keyword-face
								:state    ,#'consult--buffer-state
								:default  t
								:action (lambda (result) (call-interactively (cdr (assoc result my/menu-items))))
								:items (lambda () (mapcar #'car my/menu-items)))
		"My menu items for `consult-buffer'.")
	
  (custom-set-variables
	 '(consult-buffer-sources
     '(consult--source-hidden-buffer consult--source-modified-buffer consult--source-buffer consult--source-project-buffer consult--source-my-menu consult--source-project-recent-file consult--source-recent-file consult--source-bookmark))
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
  (("M-m" . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (define-key embark-buffer-map (kbd "M-RET") 'my/menu-base)
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
        corfu-auto t
        corfu-quit-no-match t)
  (global-corfu-mode +1))

(use-package corfu-doc
  :init
  (add-to-list 'corfu-mode-hook #'corfu-doc-mode))

(use-package savehist
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
(cua-mode +1)

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

(winner-mode +1)
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
	(set-fringe-mode 15)
  (global-auto-revert-mode 1)
  (global-visual-line-mode t)
  (global-hi-lock-mode 1)
  (pixel-scroll-precision-mode +1)
	(setq current-language-environment "UTF-8")
	(prefer-coding-system 'utf-8)
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
         ("M-m" . embark-act))))

(blink-cursor-mode 0)

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

(use-package doom-modeline
  :demand t
  :config
  (doom-modeline-mode +1)
  (setq doom-modeline-height 42)
	(setq doom-modeline-vcs-max-length 32)) ;; because the "feature/" is there everywhere :)

(use-package ctrlf
  :demand t
  :config
  (ctrlf-mode +1))

(use-package hl-line+
  :hook
  (window-scroll-functions . hl-line-flash)
  (focus-in . hl-line-flash)
  (post-command . hl-line-flash)
  :custom
  (global-hl-line-mode nil)
  (hl-line-flash-show-period 0.5)
  (hl-line-inhibit-highlighting-for-modes '(dired-mode))
  (hl-line-overlay-priority -100) ;; sadly, seems not observed by diredfl
  )

(provide 'my-core)
