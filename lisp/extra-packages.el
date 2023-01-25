;; -*- lexical-binding: t -*-

;; package init
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/bodnarlajos/straight.el/master/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-check-for-modifications nil
      straight-use-package-by-default t
      use-package-always-defer t
      completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; utils
(straight-use-package 'rg)
(straight-use-package 'consult)
(straight-use-package 'which-key)
(straight-use-package 'crux)
(straight-use-package 'easy-kill)
(straight-use-package 'diff-hl)
(straight-use-package 'all-the-icons-completion)
(straight-use-package 'move-text)
(straight-use-package 'nc)
(straight-use-package 'remember-last-theme)
(straight-use-package 'go-translate)
(use-package all-the-icons-dired
  :straight t
  :hook (dired-mode))

(use-package undo-tree
  :init (global-undo-tree-mode t)
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
(use-package dir-locals)

(use-package org-modern
  :after (org)
  :init (global-org-modern-mode +1))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; picki some comfortable binding
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
 :bind (("<M-down>" . move-text-down)
         ("<M-up>" . move-text-up)))

;; completion
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'corfu)
(straight-use-package 'vertico)
(straight-use-package 'cape)
(straight-use-package 'kind-icon)

;; programming packages
(straight-use-package 'powershell-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'angular-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'web-mode)
(straight-use-package 'yaml-mode)
(use-package csv-mode
  :config
  (custom-set-variables
   '(csv-separators '("," ";" ":"))))

;; package configurations
(with-eval-after-load 'which-key
  (diminish 'which-key-mode))

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
(all-the-icons-completion-mode +1)
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)

;; remove tramp after crux
(with-eval-after-load 'crux
  (when (featurep 'tramp)
    (tramp-unload-tramp)))

(require 'treesit)

(require 'remember-last-theme)
(remember-last-theme-with-file-enable "~/.emacs.d/last-theme")

(require 'consult)
(add-hook 'xref-backend-functions #'consult-ripgrep-symbol-at-point)

(vertico-mode +1)
(marginalia-mode +1)
(global-corfu-mode +1)
(which-key-mode +1)

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

(defvar consult--source-my-menu
  `(:name     "Quick menu item"
	      :narrow   ?f
	      :category 'buffer
	      :face     'font-lock-keyword-face
	      :default  t
	      :action (lambda (result) (call-interactively (cdr (assoc result my/menu-items))))
	      :items (lambda () (mapcar #'car my/menu-items)))
  "My menu items for `consult-buffer'.")
(defcustom my/menu-items '(("Git" . my/start-magit)
                           ("Powershell" . my/start-powershell)
                           ("Run" . execute-extended-command)
                           ("Translate" . gts-do-translate)
                           ("Notes" . my/open-notes)) "My-config menu items" :type '(alist :key-type string :value-type function))
(add-to-list 'consult-buffer-sources 'consult--source-my-menu t)

(consult-customize
 consult-line :prompt "Search: "
 consult-global-mark :preview-key (list (kbd "<down>") (kbd "<up>") (kbd "C-p") (kbd "C-n"))
 consult-mark :preview-key (list (kbd "<down>") (kbd "<up>") (kbd "C-p") (kbd "C-n")))
(setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>") (kbd "M-i")))
(custom-set-variables
 '(xref-show-xrefs-function 'consult-xref)
 '(css-indent-offset 2))

(require 'go-translate)
(setq gts-translate-list '(("de" "hu") ("en" "hu")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-bing-engine) (gts-google-engine))
       :render (gts-buffer-render)))

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

;; treesit native
(push '(css-mode . css-ts-mode) major-mode-remap-alist)
(push '(python-mode . python-ts-mode) major-mode-remap-alist)
(push '(javascript-mode . js-ts-mode) major-mode-remap-alist)
(push '(js-json-mode . json-ts-mode) major-mode-remap-alist)
(push '(typescript-mode . typescript-ts-mode) major-mode-remap-alist)
(push '(c-mode . c-ts-mode) major-mode-remap-alist)
(push '(c++-mode . c++-ts-mode) major-mode-remap-alist)
(push '(csharp-mode . csharp-ts-mode) major-mode-remap-alist)

(provide 'extra-packages)
