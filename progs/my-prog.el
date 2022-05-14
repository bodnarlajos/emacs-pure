;; -*- lexical-binding: t -*-

(use-package diff-hl
	:straight t)
(use-package dockerfile-mode
	:straight t)
(use-package yaml-mode
	:straight t)
(setq compilation-auto-jump-to-first-error nil)
(setq compilation-ask-about-save nil)
(setq compilation-scroll-output 'next-error)
(setq compilation-skip-threshold 2)
(setq eldoc-echo-area-use-multiline-p 8)
(setq eldoc-echo-area-prefer-doc-buffer t)

(defun my/local-prog-mode ()
	"T."
	(setq-local tab-width 2)
	(setq display-line-numbers-width 4)
	(display-line-numbers-mode)
	(hs-minor-mode +1)
	(diff-hl-mode t))

(add-hook 'prog-mode-hook 'my/local-prog-mode)

(custom-set-variables
 '(standard-indent 2))

(provide 'my-prog)
