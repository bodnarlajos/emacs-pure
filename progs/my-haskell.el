;; -*- lexical-binding: t -*-

(require 'my-dev)

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
  (setq haskell-compile-cabal-build-command "stack build --fast")
	:hook
	(haskell-mode . (lambda ()
										(eglot-ensure)
										(local-set-key (kbd "C-c C-c") 'my/haskell-compile))))

(use-package lsp-haskell)

(provide 'my-haskell)
