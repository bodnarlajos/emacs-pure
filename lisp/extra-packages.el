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

;; completion
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'corfu)
(straight-use-package 'vertico)
(straight-use-package 'cape)
(straight-use-package 'kind-icon)

(marginalia-mode +1)
(vertico-mode +1)
(global-corfu-mode +1)

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

(global-set-key (kbd "C-/") 'cape-dabbrev)

;; programming packages
(straight-use-package 'csharp-mode)
(straight-use-package 'powershell-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'angular-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'web-mode)

;; lsp mode
(straight-use-package 'lsp-mode)

(provide 'extra-packages)
