(require 'lsp-mode)
(require 'lsp-ui)

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
	(setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-symbol nil)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-diagnostic-max-lines 5)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor nil)
  (custom-set-faces
   '(lsp-ui-sideline-global ((t (:inverse-video t :height 0.6)))))
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-border "black")
  (add-hook 'lsp-ui-doc-frame-hook
						(lambda (frame _w)
							(set-face-attribute 'default frame 
																	:font "Fira Code" 
																	:height 120)))
  (setq lsp-ui-doc-alignment 'frame))
(setq lsp-prefer-capf nil)
(setq lsp-file-watch-threshold 3000)
(setq lsp-file-watch-ignored '("static" "\.git" "\.stack-work" "\.vscode" "bin"))

(with-eval-after-load 'lsp-ui-imenu
	(setq lsp-ui-imenu--custom-mode-line-format nil))

(defun my/toggle-lsp-ui-doc ()
  (interactive)
  (if lsp-ui-doc--bounds
			(lsp-ui-doc-hide)
    (lsp-ui-doc-show)))

(provide 'my-lsp)
