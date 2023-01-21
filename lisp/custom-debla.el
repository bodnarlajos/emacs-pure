(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 130 :width normal :foundry "SAJA" :family "Cascadia Code"))))
 '(all-the-icons-dired-dir-face ((t (:height 1.2))))
 '(header-line ((t (:inherit default :box (:line-width (1 . 1) :style flat-button)))))
 '(mode-line ((t (:box (:line-width (2 . 6) :style flat-button) :height 1.1))))
 '(mode-line-inactive ((t (:box (:line-width (2 . 6) :style flat-button) :height 1.1))))
 '(tab-bar ((t (:inherit mode-line :box (:line-width (2 . 6) :style flat-button) :height 100))))
 '(tab-bar-tab ((t (:inherit mode-line :box (:line-width (2 . 6) :style flat-button)))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(dap-netcore-install-dir "/home/lbodnar/Projects/")
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(exec-path
   '("/usr/lib/dotnet/host/fxr/6.0.11" "/home/lajbo/Projects/omnisharp-roslyn" "/home/lajbo/Projects/netcoredbg" "/home/lajbo/node_modules/.bin" "/home/lajbo/.ghcup/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/lib/emacs/29.0.50/x86_64-linux-gnu"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-clients-angular-language-server-command
   '("node" "/home/lbodnar/node_modules/@angular/language-server" "--ngProbeLocations" "/home/lbodnar/node_modules" "--tsProbeLocations" "/home/lbodnar/node_modules" "--stdio"))
 '(lsp-completion-provider :none)
 '(lsp-csharp-omnisharp-roslyn-server-dir
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(lsp-csharp-omnisharp-roslyn-store-path
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(lsp-diagnostics-provider :flymake t)
 '(lsp-headerline-breadcrumb-enable nil)
 '(next-error-recenter '(4))
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/"))
(add-to-list 'my/menu-items '("Format document" . indent-buffer))
(add-to-list 'my/menu-items '("Terminal" . 'my/start-term))
(global-hl-line-mode +1)

(message "custom file loaded")

