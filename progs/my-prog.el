;; -*- lexical-binding: t -*-

(straight-use-package 'treemacs)
(global-unset-key (kbd "<f2>"))
(global-set-key (kbd "<f2>") 'treemacs)
(straight-use-package 'diff-hl)
(straight-use-package 'highlight-indent-guides)
(straight-use-package 'smartparens)
(straight-use-package 'flycheck)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'yaml-mode)
(setq compilation-auto-jump-to-first-error nil)
(setq compilation-ask-about-save nil)
;; Stop on the first error.
(setq compilation-scroll-output 'next-error)
;; Don't stop on info or warnings.
(setq compilation-skip-threshold 2)
(setq eldoc-echo-area-use-multiline-p 8)
(setq eldoc-echo-area-prefer-doc-buffer t)
(global-hl-line-mode +1)
(with-eval-after-load 'highlight-indent-guides
	(setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-line)
	(custom-set-variables
	 '(highlight-indent-guides-method 'bitmap)))

(provide 'my-prog)
