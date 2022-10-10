;; -*- lexical-binding: t -*-

(use-package shell-mode
	:straight (:type built-in)
	:bind
	(:map shell-mode-map
				("M-RET" . consult-buffer)))

(use-package recentf
  :straight t
  :defer t
  :init
  (recentf-mode +1))

(use-package multiple-cursors)
(use-package markdown-mode
	:demand t)
(use-package json-mode
	:demand t)
(use-package powershell-mode
	:demand t)

(use-package rg
	:init
	(defun my/run/rg ()
		"Run rg without -ic parameter"
		(interactive)
		(setq-local shell-command-switch "")
		(call-interactively 'rg))
  (defun my/project/rg ()
    "T."
    (interactive)
    (let ((currProject (project-current)))
      (if currProject
          (call-interactively 'rg-project)
        (call-interactively 'rg))))
	:config
	(setq rg-ignore-case nil)
	(add-hook 'rg-mode-hook (lambda ()
														(setq-local outline-regexp "File:.+")
														(outline-minor-mode +1)))
  :bind
  ("M-s r" . my/project/rg))

(use-package hydra)
(use-package wgrep)
(use-package find-file-rg
  :straight (find-file-rg :type git :host github :repo "muffinmad/emacs-find-file-rg")
  :bind
  ("M-s f" . find-file-rg))

(use-package consult-lsp)
(show-paren-mode +1)
(which-key-mode +1)
(diminish 'which-key-mode)
(require 'dabbrev)
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

(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
(put 'list-timers 'disabled nil)

(use-package org
  :straight t
  :defer t
	:bind
	(:map org-mode-map
				("M-RET" . consult-buffer))
  :config
	(add-hook 'org-mode-hook (lambda ()
														 (define-key org-mode-map (kbd "S-M-<return>") 'org-insert-heading)))
  (add-hook 'org-mode-hook 'org-modern-mode)
  (define-key org-mode-map [mouse-1] 'org-cycle)
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "INFO-NEEDED" "TESTING" "BUSINESS TESTING" "|" "DONE" "DELEGATED" "CANCELED"))
        org-support-shift-select t
				org-adapt-indentation 'headline-data
				org-hide-emphasis-markers t
				org-startup-indented t
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
  :defer t
	:init
	(custom-set-variables
	 '(org-modern-star ["●" "●" "●" "-" "-"])))

(use-package log-view
	:straight (:type built-in)
	:config
	(define-key log-view-mode-map (kbd "<M-up>") 'log-view-msg-prev)
	(define-key log-view-mode-map (kbd "<M-down>") 'log-view-msg-next)
	(define-key log-view-mode-map (kbd "<S-left>") 'log-view-diff))

(use-package vc-git
	:straight (:type built-in)
	:config
	(define-key vc-git-log-view-mode-map (kbd "<M-up>") 'log-view-msg-prev)
	(define-key vc-git-log-view-mode-map (kbd "<M-down>") 'log-view-msg-next)
	(define-key vc-git-log-view-mode-map (kbd "<M-left>") 'log-view-diff))

(use-package git-timemachine
  :ensure t
  :demand t)

(use-package magit
	:demand t
  :commands (magit-status-quick magit-status)
	:bind
	((:map magit-mode-map ("<C-tab>" . other-window))
	 (:map magit-status-mode-map ("<C-tab>" . other-window))
	 (:map magit-log-mode-map ("<C-tab>" . other-window))
	 (:map magit-revision-mode-map ("<C-tab>" . other-window)))
	:init
	(when my/is-libgit2
		(add-to-list 'load-path my/const/libgit-path)
		(require 'libgit))
	(defun my/magit-status ()
    "Open a magit directory."
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively #'magit-status-quick)))
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
	(defun my/faster-magit ()
		"Magit without things"
		;; ;; revision
		(remove-hook 'magit-diff-sections-hook 'magit-insert-xref-buttons)
		(remove-hook 'magit-revision-sections-hook 'magit-insert-xref-buttons)
		(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-headers)
		(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-notes)
		(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-tag)
		(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-message)
		(remove-hook 'magit-section-highlight-hook 'magit-diff-highlight)
		(remove-hook 'magit-section-movement-hook 'magit-log-maybe-update-revision-buffer)
		(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-rest)
		(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-output)
		(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-log)
		(remove-hook 'magit-status-sections-hook 'magit-insert-upstream-branch-header)
		(remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
		(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
		(remove-hook 'magit-switch-hook 'magit-commit-diff)
		(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
		(setq magit-diff-highlight-indentation nil
					magit-diff-highlight-trailing nil
					magit-diff-paint-whitespace nil
					magit-diff-highlight-hunk-body nil
					magit-diff-refine-hunk nil
					magit-revision-insert-related-refs nil))
  :config
	(my/faster-magit)
	(with-eval-after-load
			(setq magit-diff-refine-hunk 'all))
  (defun my/check-magit-process-is-active ()
    "T."
    (interactive)
    (let ((result nil)
          (buffs (window-list)))
      (while buffs
        (when (string-prefix-p "magit-process:" (buffer-name (car buffs)))
          (progn
            (setq result t)
            (setq buffs nil)))
        (setq buffs (cdr buffs)))
      result))
  )

;;; Smerge
(use-package smerge-mode
  :bind (:map my-prefix
              ("m" . hydra-smerge/body))

  :init
  (progn
    (defun modi/enable-smerge-maybe ()
      "Auto-enable `smerge-mode' when merge conflict is detected."
      (save-excursion
        (goto-char (point-min))
        (when (re-search-forward "^<<<<<<< " nil :noerror)
          (smerge-mode 1))))
    (add-hook 'find-file-hook #'modi/enable-smerge-maybe :append))
  :config
  (which-key-add-key-based-replacements "M-j m" "Smerge")
  ;; (defalias 'smerge-keep-upper 'smerge-keep-mine)
  ;; (defalias 'smerge-keep-lower 'smerge-keep-other)
  ;; (defalias 'smerge-diff-base-upper 'smerge-diff-base-mine)
  ;; (defalias 'smerge-diff-upper-lower 'smerge-diff-mine-other)
  ;; (defalias 'smerge-diff-base-lower 'smerge-diff-base-other)

  (defhydra hydra-smerge (:color pink
                                 :hint nil
                                 :pre (smerge-mode 1)
                                 ;; Disable `smerge-mode' when quitting hydra if
                                 ;; no merge conflicts remain.
                                 :post (smerge-auto-leave))
    "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
    ("n" smerge-next)
    ("p" smerge-prev)
    ("b" smerge-keep-base)
    ("u" smerge-keep-upper)
    ("l" smerge-keep-lower)
    ("a" smerge-keep-all)
    ("RET" smerge-keep-current)
    ("\C-m" smerge-keep-current)
    ("<" smerge-diff-base-upper)
    ("=" smerge-diff-upper-lower)
    (">" smerge-diff-base-lower)
    ("R" smerge-refine)
    ("E" smerge-ediff)
    ("C" smerge-combine-with-next)
    ("r" smerge-resolve)
    ("k" smerge-kill-current)
    ("q" nil "cancel" :color blue)))

(use-package tab-bar
	:straight (:type built-in)
	:init
	(setq tab-bar-separator "   "
				tab-bar-tab-hints t
				tab-bar-tab-name-function 'tab-bar-tab-name-truncated
				tab-bar-tab-name-truncated-max 24)
	(defun my/open/new-tab-with-file ()
		"Open the file in new tab"
		(interactive)
		(tab-bar-mode +1)
		(tab-bar-new-tab)
		(my/start/menu))
	:bind
	("M-j RET" . my/open/new-tab-with-file)
	("M-j n" . tab-bar-switch-to-next-tab)
	("M-j x" . tab-bar-close-tab))

(use-package desktop
	:straight (:type built-in)
	:init
	(defun my/open/desktop ()
		"Open the saved destkop"
		(interactive)
		(desktop-change-dir "~/.emacs.d/desktop/")))

(use-package plz
	:init
	(defun my/plz-response (body)
		"Open a plzX buffer and write the response in to it"
		(let ((b (get-buffer-create "plz-response")))
			(switch-to-buffer b)
			(insert (format-time-string "%Y_%m_%d-%H_%M_%S"))
			(insert "\n\n")
			(insert body)
			(insert "\n\n"))))

(use-package dired+
	:init
	(defun my/start/dired-current-file ()
		"Start the current file with default application"
		(interactive)
		(diredp-copy-abs-filenames-as-kill)
		(async-shell-command (concat "start " (car kill-ring-yank-pointer)))))

(use-package go-translate
	:commands gts-do-translate
	:bind
	("<f1>" . gts-do-translate)
	:init
	(defun disable-y-or-n-p (orig-fun &rest args)
		(cl-letf (((symbol-function 'y-or-n-p) (lambda (prompt) t)))
			(apply orig-fun args)))
	(advice-add 'ediff-quit :around #'disable-y-or-n-p)
	:config
	(setq gts-translate-list '(("en" "hu")))
	;; habkker
	(setq gts-default-translator
				(gts-translator
				 :picker (gts-prompt-picker)
				 :engines (list (gts-bing-engine) (gts-google-engine))
				 :render (gts-buffer-render))))

(use-package centered-window-mode
	:config
	(setq cwm-centered-window-width 220))

(provide 'my-bloated)
