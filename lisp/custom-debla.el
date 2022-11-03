(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 128 :width normal :foundry "JB" :family "JetBrains Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(consult-buffer-sources
   '(consult--source-hidden-buffer consult--source-modified-buffer consult--source-buffer consult--source-project-buffer consult--source-project-recent-file consult--source-recent-file consult--source-bookmark consult--source-my-menu))
 '(consult-preview-key [S-up])
 '(dap-netcore-install-dir "/home/lbodnar/Projects/")
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(exec-path
   '("/home/lbodnar/Projects/netcoredbg" "/home/lbodnar/node_modules/.bin" "/home/lbodnar/.ghcup/bin" "/home/lbodnar/.nvm/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/lib/emacs/29.0.50/x86_64-linux-gnu"))
 '(global-display-line-numbers-mode t)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-clients-angular-language-server-command
   '("node" "/home/lbodnar/node_modules/@angular/language-server" "--ngProbeLocations" "/home/lbodnar/node_modules" "--tsProbeLocations" "/home/lbodnar/node_modules" "--stdio"))
 '(lsp-completion-provider :none)
 '(lsp-disabled-clients '(csharp-ls))
 '(lsp-eldoc-render-all t)
 '(lsp-headerline-breadcrumb-enable nil)
 '(next-error-recenter '(4))
 '(tool-bar-mode nil)
 '(xref-show-definitions-function 'consult-xref)
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/"))
(add-to-list 'my/menu-items '("Format document" . indent-buffer))
(add-to-list 'my/menu-items '("Duplicate line" . duplicate-line))
(add-to-list 'my/menu-items '("Terminal" . 'my/start-term))
(global-hl-line-mode +1)
