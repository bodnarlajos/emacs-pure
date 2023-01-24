(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 130 :width normal :foundry "SAJA" :family "Cascadia Code"))))
 '(all-the-icons-dired-dir-face ((t (:height 1.2))))
 '(fixed-pitch ((t (:family "Cascadia Mono"))))
 '(fixed-pitch-serif ((t (:weight semi-bold :family "Cascadia Mono"))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red"))))
 '(variable-pitch ((t (:family "Ubuntu Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("1479377d38b49d40dba561b2e4ab354b78cedb721bd62e0210ca18652760d219" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(dap-netcore-install-dir "/home/lbodnar/Projects/")
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
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
(global-hl-line-mode +1)

(message "custom file loaded")

