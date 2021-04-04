(require 'haskell-mode)
(require 'lsp-haskell)

(message "haskell init")
(with-eval-after-load 'haskell-mode
	(message "h1 init")
  (add-hook 'haskell-mode-hook (lambda ()
																 (message "haskell mode hook")
																 (when my/dev-env
																	 (message "h2 init: haskell mode hook with dev-env")
																	 (local-set-key (kbd "C-.") 'eglot-find-typeDefinition)
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

;; the hook function which going to run only once
(defun my/haskell-dev-run ()
	"haskell mode development"
	(add-hook 'haskell-mode-hook 'eglot-ensure))

(my/add-dev-hook #'my/haskell-dev-run)

(provide 'my-haskell)
