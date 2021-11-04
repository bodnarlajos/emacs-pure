(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(centaur-tabs-hide-tabs-hooks
	 '(magit-popup-mode-hook reb-mode-hook completion-list-mode-hook))
 '(consult-buffer-filter
	 '("\\` " "\\`\\*Completions\\*\\'" "\\`\\*Flymake log\\*\\'" "\\`\\*Semantic SymRef\\*\\'" "\\`\\*Messages\\*\\'" "\\`\\*straight.*\\*\\'" "\\`\\*tramp/.*\\*\\'"))
 '(custom-safe-themes
	 '("6f4421bf31387397f6710b6f6381c448d1a71944d9e9da4e0057b3fe5d6f2fad" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" "246a9596178bb806c5f41e5b571546bb6e0f4bd41a9da0df5dfbca7ec6e2250c" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "a99fb53a1d22ce353cab8db2fe59353781c13a4e1d90455f54f7e60c061bc9f4" "58fb295e041032fd7a61074ca134259dfdef557ca67d37c4240dbfbb11b8fcc7" default))
 '(highlight-indent-guides-method 'bitmap)
 '(ispell-dictionary nil)
 '(lsp-ui-doc-show-with-cursor nil)
 '(menu-bar-mode nil)
 '(selectrum-max-window-height 15)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "CYEL" :slant normal :weight normal :height 128 :width normal))))
 '(magit-diff-hunk-heading ((t (:extend t :background "#564b64" :foreground "gray")))))
