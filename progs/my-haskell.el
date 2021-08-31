(straight-use-package 'haskell-mode)
(straight-use-package 'lsp-haskell)

(message "haskell init")
(with-eval-after-load 'haskell-mode
	(message "haskell init")
  (add-hook 'haskell-mode-hook (lambda ()
																 (message "h1 init")
																 (local-set-key (kbd "C-c C-c") 'my/haskell-compile)
																 (message "h1 end")))
  (setq haskell-compile-cabal-build-command "stack build --fast")
  (defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\""))
	(message "haskell end"))

(setq haskell-stylish-on-save t)

;; the hook function which going to run only once
(defun my/haskell-dev-run ()
	"haskell mode development"
	(add-hook 'haskell-mode-hook (lambda ()
																 (message "h2 init: haskell mode hook with dev-env")
																 (lsp)
																 ;; (eglot-ensure)
																 ;; (local-set-key (kbd "C-.") 'eglot-find-typeDefinition)
																 (local-set-key (kbd "C-c h") 'haskell-hoogle-lookup-from-local)
																 (message "h2 end"))))

(my/add-dev-hook #'my/haskell-dev-run)

(message "haskell end")

(provide 'my-haskell)
