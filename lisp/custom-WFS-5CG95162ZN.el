(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 100 :width normal :foundry "JB" :family "JetBrains Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-styles '(orderless))
 '(custom-enabled-themes '(tsdh-light))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-headerline-breadcrumb-enable nil)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t))

(setq my/notes-path (expand-file-name "~/Box/notes/"))
