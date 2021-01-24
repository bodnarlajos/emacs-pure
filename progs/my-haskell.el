(with-eval-after-load 'haskell-mode
	(message "haskell-mode after eval")
  ;; Hooks so haskell and literate haskell major modes trigger LSP setup
  (my/load-my "haskell-debug")
  (add-hook 'haskell-mode-hook (lambda ()
																 (lsp)
																 (local-set-key (kbd "C-c C-c") 'my/haskell-compile)
																 (local-set-key (kbd "C-.") 'lsp-goto-type-definition)
																 (local-set-key (kbd "C-t") 'my/toggle-lsp-ui-doc)
																 (local-set-key (kbd "C-c h") 'haskell-hoogle-lookup-from-local)
																 (message "haskell-mode-inited")))

  (setq haskell-compile-cabal-build-command "stack build")
  (defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")))

(straight-use-package 'haskell-mode)
(straight-use-package 'shakespeare-mode)
(straight-use-package 'lsp-haskell)
(my/load-my "dev")

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(setq compilation-scroll-output t)
(setq lsp-prefer-capf nil)
(setq lsp-file-watch-threshold 3000)
(setq haskell-stylish-on-save t)
(setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
(setq lsp-haskell-process-args-hie '())
(setq lsp-file-watch-ignored '("static" "\.git" "\.stack-work" "\.vscode" "bin"))

(my/installed "haskell")
