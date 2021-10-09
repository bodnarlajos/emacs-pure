;; -*- lexical-binding: t -*-

(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)

(with-eval-after-load 'lsp-ui
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (custom-set-variables
   '(lsp-ui-sideline-ignore-duplicate t))
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-doc-delay 2.0)
  (setq lsp-ui-doc-hide-delay 2)
  (setq lsp-ui-doc-use-webkit nil)
  (setq lsp-ui-doc-use-childframe t)
  (setq lsp-ui-doc-header nil)
  (setq lsp-ui-doc-include-signature nil)
	(setq lsp-ui-doc-border 'black)
	(setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-ui-sideline-show-symbol nil)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-diagnostic-max-lines 5)
  (setq lsp-ui-doc-enable t)
  (custom-set-faces
   '(lsp-ui-sideline-global ((t (:inverse-video t :height 0.6)))))
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-border "black")
  (add-hook 'lsp-ui-doc-frame-hook
						(lambda (frame _w)
							(set-face-attribute 'default frame 
																	:font "Fira Code" 
																	:height 110)))
  (setq lsp-ui-doc-alignment 'frame)
	(custom-set-variables
	 '(highlight-indent-guides-method 'bitmap)
	 '(lsp-ui-peek-enable nil)
	 '(lsp-ui-doc-border "black")
	 '(lsp-ui-doc-show-with-cursor nil)
	 '(lsp-ui-doc-show-with-mouse t)
	 '(lsp-headerline-breadcrumb-enable nil)
	 '(lsp-ui-sideline-ignore-duplicate t)
	 '(lsp-ui-sideline-update-mode 'line)))

(setq lsp-prefer-capf nil)
(setq lsp-file-watch-threshold 3000)
(setq lsp-file-watch-ignored '("static" "\.git" "\.stack-work" "\.vscode" "bin"))

(with-eval-after-load 'lsp-ui-imenu
	(setq lsp-ui-imenu--custom-mode-line-format nil))

(defun my/toggle-lsp-ui-doc ()
	(interactive)
	(when lsp-ui-doc--bounds
		(my/toogle-lsp-ui-doc-kill-timer))
	(lsp-ui-doc-hide)
	(lsp-ui-doc-show)
	(setq my/lspTimerId (run-at-time 10 nil 'lsp-ui-doc-hide)))

(defvar my/lspTimerId nil "The lsp timer's identifier")

(defun my/toogle-lsp-ui-doc-kill-timer ()
	"T."
	(interactive)
	(when my/lspTimerId
		(message "cancel-timer: %s" my/lspTimerId)
		(cancel-timer my/lspTimerId)))

(provide 'my-lsp)
