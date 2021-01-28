(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook (lambda ()
																 (lsp)
																 (local-set-key (kbd "C-c C-c") 'my/haskell-compile)
																 (local-set-key (kbd "C-.") 'lsp-goto-type-definition)
																 (local-set-key (kbd "C-t") 'my/toggle-lsp-ui-doc)
																 (local-set-key (kbd "C-c h") 'haskell-hoogle-lookup-from-local)))
  (setq haskell-compile-cabal-build-command "stack build --fast")
  (defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")))

(require 'haskell-mode)
(require 'lsp-haskell)

(add-hook 'haskell-mode-hook #'lsp)
(setq haskell-stylish-on-save t)
(setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
(setq lsp-haskell-process-args-hie '())

(provide 'my-haskell)
