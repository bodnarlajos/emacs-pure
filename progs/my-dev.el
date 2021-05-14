(straight-use-package 'diff-hl)
(straight-use-package 'highlight-indent-guides)
(straight-use-package 'smartparens)
(straight-use-package 'company-quickhelp)
(straight-use-package 'company)
(global-company-mode t)
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
(straight-use-package 'eglot)
(straight-use-package 'posframe)
(require 'eldoc-posframe)
(global-eldoc-posframe-mode +1)
(global-eldoc-posframe-enable)
(straight-use-package 'yaml-mode)
(require 'my-jump)

(with-eval-after-load 'highlight-indent-guides
	(custom-set-variables
	 '(highlight-indent-guides-method 'bitmap)))

(defun my/local-prog-mode ()
	"T."
	(setq-local tab-width 2)
	(display-line-numbers-mode)
	(highlight-indent-guides-mode t)
	(diff-hl-mode t)
	(company-quickhelp-local-mode)
	(smartparens-mode))

(setq compilation-auto-jump-to-first-error nil)
(setq compilation-ask-about-save nil)
;; Stop on the first error.
(setq compilation-scroll-output 'next-error)
;; Don't stop on info or warnings.
(setq compilation-skip-threshold 2)
(setq eldoc-echo-area-use-multiline-p 8)
(setq eldoc-echo-area-prefer-doc-buffer t)
(add-hook 'prog-mode-hook 'my/local-prog-mode)
(setq company-minimum-prefix-length 1)

(when (and (not my/dev-env) my/dev-hook)
	(run-hooks 'my/dev-hook))

(setq my/dev-env t)

;; (purpose-load-window-layout "development")

(message "dev end")

(provide 'my-dev)
