(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 100 :width normal :foundry "JB" :family "JetBrains Mono"))))
 '(variable-pitch ((t (:slant normal :weight bold :height 100 :foundry "outline" :family "Roboto Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(consult-buffer-sources
   '(consult--source-hidden-buffer consult--source-modified-buffer consult--source-buffer consult--source-project-buffer consult--source-project-recent-file consult--source-recent-file consult--source-bookmark consult--source-my-menu))
 '(consult-preview-key [S-up])
 '(corfu-auto nil)
 '(diff-command "c:/Users/lbodnar/scoop/shims/sdiff.exe")
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-completion-provider :none)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t)
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Box/notes/"))
(cd "c:/Projects")
