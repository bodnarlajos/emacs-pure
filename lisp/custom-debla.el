(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 130 :width normal :family "Fira Code"))))
 '(all-the-icons-dired-dir-face ((t (:height 1.2))))
 '(fixed-pitch ((t (:family "JetBrains Mono"))))
 '(fixed-pitch-serif ((t (:inherit default :weight semi-bold :family "JetBrains Mono"))))
 '(tab-bar ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0)))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (4 . 4) :style flat-button) :underline (:color foreground-color :style line :position 0)))))
 '(tab-line ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0) :box (:line-width (4 . 4) :style flat-button)))))
 '(tab-line-tab ((t (:inherit tab-line :style flat-button) :underline (:color foreground-color :style line :position 0))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red"))))
 '(variable-pitch ((t (:family "JetBrains Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(csv-separators '("," ";" ":"))
 '(custom-safe-themes
   '("b64a60e69617b4348d0402fad2f0d08a694301132e7ab243dab4d6a65c3bf948" "c2efe6f5e2bd0bddfb2d6e26040545768939d2029f77e6b6a18d1ee0e0cb1033" "f48be80177f0d9a2b19d8dc19f3903d9be3c4d885d110e82b591d1184586fad0" "aee6debe7b326de2968d8b023fdc9ee7e6c9996a80532186674f2e1376ad1782" "1479377d38b49d40dba561b2e4ab354b78cedb721bd62e0210ca18652760d219" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(dap-netcore-install-dir "/home/lbodnar/Projects/")
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(exec-path
   '("/home/lajbo/.daml/bin" "/usr/lib/dotnet/host/fxr/6.0.11" "/home/lajbo/Projects/omnisharp-roslyn" "/home/lajbo/Projects/netcoredbg" "/home/lajbo/node_modules/.bin" "/home/lajbo/.ghcup/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/lib/emacs/29.0.50/x86_64-linux-gnu"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-clients-angular-language-server-command
   '("node" "/home/lbodnar/node_modules/@angular/language-server" "--ngProbeLocations" "/home/lbodnar/node_modules" "--tsProbeLocations" "/home/lbodnar/node_modules" "--stdio"))
 '(lsp-completion-provider :none)
 '(lsp-csharp-omnisharp-roslyn-server-dir
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(lsp-csharp-omnisharp-roslyn-store-path
   "/home/lajbo/.emacs.d/.cache/lsp/omnisharp-roslyn/latest/omnisharp-roslyn/OmniSharp")
 '(lsp-diagnostics-provider :flymake)
 '(lsp-headerline-breadcrumb-enable nil)
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(package-selected-packages
   '(mini-frame daml-mode multi-eshell eat hercules magit eldoc-box lsp-haskell consult-lsp dap-mode lsp-mode isearch+ rg anzu markdown-mode typescript-mode corfu yaml-mode angular-mode diminish move-text orderless plz vterm go-translate ef-themes csv-mode cape kind-icon web-mode undo-tree js2-mode easy-kill dogears org-modern with-editor diff-hl all-the-icons-completion haskell-mode embark-consult vertico marginalia crux remember-last-theme which-key))
 '(safe-local-variable-values
   '((my/dap/name . "dap-haskell-test1")
     (my/dap/entry-point . "app/Main.hs")
     (my/dap/working-directory . "/home/lajbo/Projects/haskell-projects/test1/")))
 '(treemacs-RET-actions-config
   '((treemacs-lsp-treemacs-generic-root-open . treemacs-collapse-extension-node)
     (root-node-open . treemacs-toggle-node)
     (root-node-closed . treemacs-toggle-node)
     (dir-node-open . treemacs-toggle-node)
     (dir-node-closed . treemacs-toggle-node)
     (file-node-open . treemacs-visit-node-in-most-recently-used-window)
     (file-node-closed . treemacs-visit-node-in-most-recently-used-window)
     (tag-node-open . treemacs-toggle-node-prefer-tag-visit)
     (tag-node-closed . treemacs-toggle-node-prefer-tag-visit)
     (tag-node . treemacs-visit-node-default)))
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Insync/bodnarlajoska@gmail.com/Google Drive/Documents/notes/"))
(global-hl-line-mode +1)

(message "custom file loaded")

