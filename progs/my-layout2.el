(straight-use-package 'window-purpose)
(purpose-mode)

(add-to-list 'purpose-user-mode-purposes '(haskell-mode   . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(text-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(fundamental-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(css-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(javascript-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(js2-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(typescript-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(web-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(dired-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(emacs-lisp-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(less-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(org-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(so-long-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(nxml-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(zip-archive-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(archive-mode . main-purpose))
(add-to-list 'purpose-user-mode-purposes '(undo-tree-visualizer-mode . second-purpose))
(add-to-list 'purpose-user-mode-purposes '(help-mode . second-purpose))
(add-to-list 'purpose-user-mode-purposes '(haskell-compilation-mode . second-purpose))
(add-to-list 'purpose-user-mode-purposes '(compilation-mode . second-purpose))
(add-to-list 'purpose-user-mode-purposes '(rg-mode . second-purpose))

(purpose-compile-user-configuration)

(provide 'my-layout2)
