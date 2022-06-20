;; -*- lexical-binding: t -*-
(straight-use-package 'haskell-mode)
(straight-use-package 'lsp-haskell)

(with-eval-after-load 'haskell-mode
  (add-hook 'haskell-mode-hook (lambda ()
																 (local-set-key (kbd "C-c C-c") 'my/haskell-compile)))
  (setq haskell-compile-cabal-build-command "stack build --fast")
  (defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")))

(setq haskell-stylish-on-save t)

(provide 'my-haskell)
