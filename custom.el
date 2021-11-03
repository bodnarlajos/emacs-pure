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
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
	 '("7354d92a4dde1b8071a0b21937e3d792abd956b983530d27788acbda0eb9b9d3" "95352bfdb489c0d8a5d00760427f6c400945dd5e7b1998f37f4998e53728f2c8" "860a2d0be28108334c92c07ad4293ad8b4138ef5d5af700e754974401a9ad753" "874dea847a30db30ad2aef7ae3c0d6866ee1dbe9f02d8e40d434301cee47120d" "8b9d07b01f2a9566969c2049faf982cab6a4b483dd43de7fd6a016bb861f7762" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "a99fb53a1d22ce353cab8db2fe59353781c13a4e1d90455f54f7e60c061bc9f4" "58fb295e041032fd7a61074ca134259dfdef557ca67d37c4240dbfbb11b8fcc7" default))
 '(dumb-jump-max-find-time 5)
 '(dumb-jump-preferred-searcher 'rg)
 '(dumb-jump-selector 'completing-read)
 '(ediff-diff-program "C:\\\\msys64_\\\\usr\\\\bin\\\\diff.exe")
 '(ediff-diff3-program "C:\\\\msys64_\\\\usr\\\\bin\\\\diff3.exe")
 '(highlight-indent-guides-method 'bitmap)
 '(ispell-dictionary nil)
 '(lsp-ui-doc-show-with-cursor nil)
 '(mini-frame-color-shift-step 12)
 '(mini-frame-internal-border-color "forest green")
 '(mini-frame-mode t)
 '(mini-frame-show-parameters '((top . 20) (width . 0.7) (left . 0.5) (height . 25)))
 '(selectrum-max-window-height 15)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "outline" :slant normal :weight normal :height 98 :width normal))))
 '(magit-diff-added ((t (:extend t :background "pale green" :foreground "steel blue"))))
 '(magit-diff-removed ((t (:extend t :background "#ffe8ef" :foreground "orange red")))))
 ;; '(magit-diff-added ((t (:extend t :background "pale green" :foreground "steel blue"))))
 ;; '(magit-diff-removed ((t (:extend t :background "#ffe8ef" :foreground "orange red"))))
 ;; '(magit-section-highlight ((t (:inherit nil))))
 ;; '(minibuffer-prompt ((t (:inherit modus-themes-prompt :background "floral white" :foreground "orange red")))))
