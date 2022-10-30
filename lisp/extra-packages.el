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

;; completion
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'corfu)
(straight-use-package 'vertico)
(straight-use-package 'cape)
(straight-use-package 'kind-icon)
;; programming packages
(straight-use-package 'csharp-mode)
(straight-use-package 'powershell-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'angular-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'web-mode)
(straight-use-package 'yaml-mode)

;; package configurations
(require 'consult)
(vertico-mode +1)
(marginalia-mode +1)
(global-corfu-mode +1)
(which-key-mode +1)

(setq corfu-cycle nil
      corfu-quit-at-boundary nil
      corfu-auto-prefix 2
      corfu-auto nil
      corfu-quit-no-match t
      vertico-count 13
      vertico-cycle t
      kind-icon-default-face 'corfu-default
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
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)

(with-eval-after-load 'lsp-mode
  (setq lsp-headerline-breadcrumb-enable nil)
  (add-to-list 'lsp-file-watch-ignored-directories "bin"))

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

(defcustom my/menu-items '(("Notes" . my/open-notes)
		           ("Git" . vc-dir)
                           ("Powershell" . my/start-powershell)
                           ("Back" . 'consult-mark)
                           ("Eval region" . eval-region)
                           ("BackGlobal" . consult-global-mark)
                           ("Run" . execute-extended-command)) "My-config menu items" :type '(alist :key-type string :value-type function))

(consult-customize
 consult-line :prompt "Search: ")

(provide 'extra-packages)
