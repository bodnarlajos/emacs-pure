;; -*- lexical-binding: t -*-

(use-package haskell-mode
	:straight t
	:init
	(defun my/haskell-compile ()
    "T."
    (interactive)
    (setq-local haskell-compile-cabal-build-command "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\"")
    (haskell-compile "stack build --fast --ghc-options=\"-j +RTS -A32M -RTS\""))
	:config
	(setq haskell-stylish-on-save t)
  (setq haskell-compile-cabal-build-command "stack build --fast"))

(provide 'my-haskell)
