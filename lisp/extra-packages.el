;; -*- lexical-binding: t -*-

;; utils
(use-package rg
  :ensure t)
(use-package consult
  :ensure t
  :config
  (setq consult-preview-key "S-<right>"))
(use-package which-key
  :after (diminish)
  :init
  (diminish 'which-key-mode)
  :config
  (which-key-mode +1))
(use-package crux)
(use-package diff-hl)
(use-package with-editor)

(use-package nerd-icons)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package undo-tree
  :after (diminish)
  :init
  (global-undo-tree-mode t)
  (diminish 'undo-tree-mode)
  :bind (("C-z" . undo-tree-undo)
         ("C-y" . undo-tree-redo))
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo/")))
  (custom-set-faces
   '(undo-tree-visualizer-active-branch-face ((t (:foreground "red")))))
  (add-to-list 'display-buffer-alist
	       '("\\*undo-tree\\*"
	         (display-buffer-reuse-window display-buffer-in-side-window)
	         (window-width . 60)
	         (side . right)
                 (slot . 2))))

(use-package org-modern
  :after (org)
  :init (global-org-modern-mode +1))

(use-package embark
  :bind
  (("M-e" . embark-act)         ;; picki some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package move-text
  :bind (("<M-S-down>" . move-text-down)
         ("<M-S-up>" . move-text-up)))

(use-package hydra)

;; completion
(use-package diminish)
(use-package orderless)
(use-package marginalia)
(use-package corfu)
(use-package vertico)
(use-package cape)
(use-package kind-icon)

;; programming packages
(use-package haskell-mode
  :config
  (add-hook 'haskell-mode-hook (lambda ()
                                 (setq compile-command "make build"))))
(use-package angular-mode)
(use-package typescript-mode)
(use-package js2-mode)
(use-package web-mode)
(use-package markdown-mode)
(use-package yaml-mode)
(use-package csv-mode
  :config
  (custom-set-variables
   '(csv-separators '("," ";" ":"))))

;; package configurations
(with-eval-after-load 'eldoc
  (diminish 'eldoc-mode)
  (custom-set-variables
   '(eldoc-documentation-strategy 'eldoc-documentation-compose)
   '(eldoc-echo-area-prefer-doc-buffer t)))

(with-eval-after-load 'visual-line
  (diminish 'visual-line-mode))

(setq kind-icon-default-face 'corfu-default)
(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))
(move-text-default-bindings)

(require 'consult)
(add-hook 'xref-backend-functions #'consult-ripgrep-symbol-at-point)

(vertico-mode +1)
(marginalia-mode +1)
(global-corfu-mode +1)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xaml\\'" . web-mode))

(add-hook 'prog-mode-hook 'diff-hl-mode)

(setq corfu-cycle nil
      corfu-quit-at-boundary nil
      corfu-auto-prefix 2
      corfu-auto nil
      corfu-quit-no-match t
      vertico-count 13
      vertico-cycle t
      completion-styles '(orderless)
      orderless-matching-styles '(orderless-flex orderless-literal orderless-regexp)
      cape-dabbrev-min-length 2
      vertico-resize t)

(defun my/setup-elisp ()
  (setq-local completion-at-point-functions
              '(elisp-completion-at-point
                cape-dabbrev
                cape-file)
              cape-dabbrev-min-length 2))

(setq completion-at-point-functions '(cape-line))
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)
(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

(custom-set-variables
 '(xref-show-xrefs-function 'consult-xref)
 '(css-indent-offset 2))


(add-hook 'csharp-mode-hook (lambda ()
                              (setq compile-command "dotnet build")))

(with-eval-after-load 'smerge-mode
  (defun modi/enable-smerge-maybe ()
    "Auto-enable `smerge-mode' when merge conflict is detected."
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^<<<<<<< " nil :noerror)
        (smerge-mode 1))))
  (add-hook 'find-file-hook #'modi/enable-smerge-maybe :append)
  
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

(use-package visual-fill-column
  :after (org-present)
  :config
  (defun my/org-present-quit ()
    "Finish a presentation with org."
    (interactive)
    (org-present-mode -1)
    (org-present-quit)
    (visual-fill-column-mode -1))
  (add-hook 'org-present-mode-hook (lambda ()
                                     (visual-fill-column-mode)
                                     (setq visual-fill-column-width 110
                                           visual-fill-column-center-text t))))

(use-package org-present)
(use-package org
  :custom
  (org-cycle-emulate-tab nil))

(when (string-equal system-type "windows-nt")
  (use-package powershell)
  (use-package ob-powershell))

(use-package eglot
  :ensure nil
  :config
  (define-key eglot-mode-map (kbd "C-.") 'eglot-code-actions)
  (add-hook 'eglot-managed-mode-hook 'eldoc-box-hover-mode)
  ;; disable logging
  (setq eglot-events-buffer-size 0))

(use-package eldoc-box
  :defer t
  :after eglot
  :config
  (custom-set-variables
   '(eldoc-box-max-pixel-width 600)))

(use-package plz)

(provide 'extra-packages)
