(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 100 :width normal :foundry "JB" :family "JetBrains Mono"))))
 '(variable-pitch ((t (:slant normal :weight bold :height 100 :foundry "outline" :family "Roboto Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups")))
 '(consult-buffer-sources
   '(consult--source-hidden-buffer consult--source-modified-buffer consult--source-buffer consult--source-project-buffer consult--source-project-recent-file consult--source-recent-file consult--source-bookmark consult--source-my-menu))
 '(consult-preview-key [S-up])
 '(corfu-auto nil)
 '(dap-netcore-install-dir "c:/Projects/")
 '(diff-command "c:/Users/lbodnar/scoop/shims/sdiff.exe")
 '(exec-path
   '("c:/Program Files/dotnet/" "c:/Projects/netcoredbg" "c:/Users/LBODNAR/scoop/apps/emacs-k/current/bin/" "c:/Users/LBODNAR/scoop/apps/emacs-k/current/usr/bin/" "c:/ProgramData/chocolatey/bin" "C:/WINDOWS/system32" "C:/WINDOWS" "C:/WINDOWS/System32/Wbem" "C:/WINDOWS/System32/WindowsPowerShell/v1.0/" "C:/WINDOWS/System32/OpenSSH/" "C:/Program Files (x86)/Box/Box Edit/" "C:/Program Files/dotnet/" "C:/Program Files (x86)/Microsoft SQL Server/150/DTS/Binn/" "C:/Program Files/Azure Data Studio/bin" "C:/Program Files/Microsoft SQL Server/130/Tools/Binn/" "C:/Program Files/Microsoft SQL Server/Client SDK/ODBC/170/Tools/Binn/" "C:/Program Files (x86)/Microsoft SQL Server/110/DTS/Binn/" "C:/Program Files (x86)/Microsoft SQL Server/120/DTS/Binn/" "C:/Program Files (x86)/Microsoft SQL Server/130/DTS/Binn/" "C:/Program Files (x86)/Microsoft SQL Server/140/DTS/Binn/" "C:/Program Files (x86)/Microsoft SQL Server/150/Tools/Binn/" "C:/Program Files/Microsoft SQL Server/150/Tools/Binn/" "C:/Program Files/Microsoft SQL Server/150/DTS/Binn/" "C:/Program Files (x86)/dotnet/" "C:/Program Files (x86)/Gpg4win/../GnuPG/bin" "C:/TDM-GCC-64/bin" "C:/Program Files/nodejs/" "C:/Program Files/Git/cmd" "C:/Users/LBODNAR/scoop/apps/vscode/current/bin" "C:/Users/LBODNAR/scoop/apps/gsudo/current" "C:/Users/LBODNAR/scoop/shims" "C:/Users/LBODNAR/.emacs.d/Git/bin" "C:/Users/LBODNAR/.emacs.d/Git/usr/bin" "C:/Users/LBODNAR/.emacs.d/Git/cmd" "c:/msys64" "c:/msys64/mingw64/bin" "c:/msys64/usr/bin" "C:/Users/LBODNAR/.cargo/bin" "c:/ProgramData/emacs-native/bin" "C:/ProgramData/emacs-native/libexec/emacs/29.0.50/x86_64-w64-mingw32" "c:/msys64/mingw32/bin" "C:/Users/LBODNAR/AppData/Local/Microsoft/WindowsApps" "C:/Users/LBODNAR/.dotnet/tools" "C:/Program Files/Azure Data Studio/bin" "C:/Users/LBODNAR/AppData/Roaming/npm" "C:/Users/LBODNAR/AppData/Local/Programs/Microsoft VS Code" "C:/Program Files/OpenSSL-Win64/bin" "C:/ProgramData/sqlToolService" "C:/Users/LBODNAR/AppData/Local/Programs/oh-my-posh/bin" "C:/Users/LBODNAR/.dotnet/tools" "C:/Users/LBODNAR/AppData/Local/gitkraken/bin" "C:/Users/LBODNAR/.deno/bin" "C:/Users/LBODNAR/AppData/Local/GitHubDesktop/bin" "C:/Users/LBODNAR/.dotnet/tools" "c:/Users/LBODNAR/scoop/apps/emacs-k/current/libexec/emacs/29.0.50/x86_64-w64-mingw32"))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-completion-provider :none)
 '(lsp-headerline-breadcrumb-enable nil)
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(safe-local-variable-values '((flycheck-disabled-checkers emacs-lisp-checkdoc)))
 '(xref-show-xrefs-function 'consult-xref))

(setq my/notes-path (expand-file-name "~/Box/notes/"))
(cd "c:/Projects")
