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

;; completion
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'corfu)
(straight-use-package 'vertico)
(straight-use-package 'cape)

;; programming packages
(straight-use-package 'csharp-mode)
(straight-use-package 'powershell-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'angular-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'web-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'go-translate)

;; package configurations

;; remove tramp after crux
(when (featurep 'tramp)
  (unload-feature 'tramp t))

(require 'consult)
(vertico-mode +1)
(marginalia-mode +1)
(global-corfu-mode +1)
(which-key-mode +1)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
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

(add-to-list 'consult-buffer-sources 'consult--source-my-menu)

(consult-customize
 consult-line :prompt "Search: ")

(custom-set-variables
 '(xref-show-xrefs-function 'consult-xref))

(defcustom my/menu-items '(("Notes" . my/open-notes)
		           ("Git" . vc-dir)
                           ("Back" . 'consult-mark)
                           ("Eval region" . eval-region)
                           ("Magit start" . my/start-magit)
                           ("BackGlobal" . consult-global-mark)
                           ("Powershell" . my/start-powershell)
                           ("Translate" . gts-do-translate)
                           ("Run" . execute-extended-command)) "My-config menu items" :type '(alist :key-type string :value-type function))

(consult-customize
 consult-line :prompt "Search: ")

(require 'go-translate)
(setq gts-translate-list '(("en" "hu")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-bing-engine) (gts-google-engine))
       :render (gts-buffer-render)))

(add-hook 'csharp-mode-hook (lambda ()
                              (setq compile-command "dotnet build")))

(provide 'extra-packages)
