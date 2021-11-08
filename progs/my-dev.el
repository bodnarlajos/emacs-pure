;; -*- lexical-binding: t -*-

(straight-use-package 'treemacs)
(global-unset-key (kbd "<f2>"))
(global-set-key (kbd "<f2>") 'treemacs)
(straight-use-package 'diff-hl)
(straight-use-package 'highlight-indent-guides)
(straight-use-package 'smartparens)
;; (straight-use-package 'company-quickhelp)
(straight-use-package 'company)
(global-company-mode t)
(straight-use-package 'flycheck)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'yaml-mode)
(require 'my-jump)

(add-hook 'my/dev-hook (lambda ()
												 (straight-use-package 'lsp-mode)
												 (straight-use-package 'lsp-ui)
												 (add-hook 'lsp-ui-doc-frame-hook
																	 (lambda (frame _w)
																		 (set-face-attribute 'default frame :font "JetBrains Mono" :height 90)))
												 (custom-set-variables
													'(lsp-ui-doc-show-with-cursor nil))))


(with-eval-after-load 'highlight-indent-guides
	(custom-set-variables
	 '(highlight-indent-guides-method 'bitmap)))

(defun my/local-prog-mode ()
	"T."
	(setq-local tab-width 2)
	(display-line-numbers-mode)
	(highlight-indent-guides-mode t)
	(diff-hl-mode t)
	(smartparens-mode +1))

(setq compilation-auto-jump-to-first-error nil)
(setq compilation-ask-about-save nil)
;; Stop on the first error.
(setq compilation-scroll-output 'next-error)
;; Don't stop on info or warnings.
(setq compilation-skip-threshold 2)
(setq eldoc-echo-area-use-multiline-p 8)
(setq eldoc-echo-area-prefer-doc-buffer t)
(add-hook 'prog-mode-hook 'my/local-prog-mode)
(setq company-minimum-prefix-length 3)

(defun my/run-dev-hook ()
	"T."
	(when (and (not my/dev-env) my/dev-hook)
		(run-hooks 'my/dev-hook)
		(setq my/dev-env t)))

(defun my/add-dev-hook (fv)
	"Add or run a function when dev mode is active or not"
	(if my/dev-env
			(funcall fv)
		(add-hook 'my/dev-hook fv)))

(defun my/start-dev-env ()
	"T."
	(interactive)
	(my/run-dev-hook)
	(my/revert-current-buffer))

(global-hl-line-mode +1)

(message "dev end")

(provide 'my-dev)
