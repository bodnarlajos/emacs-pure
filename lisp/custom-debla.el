(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 120 :width normal :foundry "SAJA" :family "Cascadia Code")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(dap-netcore-install-dir "/home/lbodnar/Projects/")
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(exec-path
   '("/usr/lib/dotnet/host/fxr/6.0.11" "/home/lajbo/Projects/omnisharp-roslyn" "/home/lajbo/Projects/netcoredbg" "/home/lajbo/node_modules/.bin" "/home/lajbo/.ghcup/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/lib/emacs/29.0.50/x86_64-linux-gnu"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-clients-angular-language-server-command
   '("node" "/home/lbodnar/node_modules/@angular/language-server" "--ngProbeLocations" "/home/lbodnar/node_modules" "--tsProbeLocations" "/home/lbodnar/node_modules" "--stdio"))
 '(lsp-csharp-omnisharp-roslyn-server-dir
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(lsp-csharp-omnisharp-roslyn-store-path
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(next-error-recenter '(4))
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/"))
(add-to-list 'my/menu-items '("Format document" . indent-buffer))
(add-to-list 'my/menu-items '("Terminal" . 'my/start-term))
(global-hl-line-mode +1)

(message "custom file loaded")

