(straight-use-package 'haskell-mode)
(straight-use-package 'lsp-haskell)

(message "haskell init")
(with-eval-after-load 'haskell-mode
	(message "h1 init")
  (add-hook 'haskell-mode-hook (lambda ()
																 (message "haskell mode hook")
																 (when my/dev-env
																	 (message "h2 init: haskell mode hook with dev-env")
																	 (lsp)
																	 (local-set-key (kbd "C-.") 'lsp-goto-type-definition)
																	 (local-set-key (kbd "<M-up>") 'my/toggle-lsp-ui-doc)
																	 (local-set-key (kbd "C-c h") 'haskell-hoogle-lookup-from-local)
																	 (message "h2 end"))
																 (local-set-key (kbd "C-c C-c") 'my/haskell-compile)))
  (setq haskell-compile-cabal-build-command "stack build --fast")
  (defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\""))
	(message "h1 end"))

(setq haskell-stylish-on-save t)

(defun my/haskell-dev-run ()
	"haskell mode development"
	(interactive)
	(setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
	(setq lsp-haskell-process-args-hie '()))

(if my/dev-env
		(my/haskell-dev-run)
	(add-hook 'my/dev-hook 'my/haskell-dev-run))

(message "haskell end")

;; (setq auto-mode-alist (delete my/init-haskell-type auto-mode-alist))
(setq auto-mode-alist (delete my/init-haskell-type auto-mode-alist))

(provide 'my-haskell)
