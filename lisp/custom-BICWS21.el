(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-automatic-bookmark-mode-delay 5)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(case-fold-search t)
 '(column-number-mode t)
 '(connection-local-criteria-alist
   '(((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(css-indent-offset 2)
 '(csv-separators '("," ";" ":"))
 '(cua-mode t)
 '(custom-safe-themes
   '("2d48bd895a307a623367f5eb240bfdb453dc1ad5dbc4fbf915b0a709dfb772a8" "94843bc0a0b482f77063b94b93efdabf646a52f7a947f5a0ed2bdcaf109f11ca" "261c8375d5a7d3a7832879d64d7ded31d71bffcad5ee7141bbbba1e83fd49015" "afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" default))
 '(desktop-base-file-name "~/.emacs.d/.cache/.emacs.desktop")
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(exec-path
   '("c:/emacs/bin" "c:/Program Files (x86)/Intel/iCLS Client/" "C:/Program Files/Intel/iCLS Client/" "C:/WINDOWS/system32" "C:/WINDOWS" "C:/WINDOWS/System32/Wbem" "C:/WINDOWS/System32/WindowsPowerShell/v1.0/" "C:/Program Files (x86)/Intel/Intel(R) Management Engine Components/DAL" "C:/Program Files/Intel/Intel(R) Management Engine Components/DAL" "C:/Program Files (x86)/Intel/Intel(R) Management Engine Components/IPT" "C:/Program Files/Intel/Intel(R) Management Engine Components/IPT" "c:/Program Files (x86)/HP/HP Performance Advisor" "C:/WINDOWS/System32/OpenSSH/" "C:/Program Files/dotnet/" "C:/Program Files/Microsoft SQL Server/130/Tools/Binn/" "C:/Program Files/Microsoft SQL Server/Client SDK/ODBC/170/Tools/Binn/" "C:/PROGRA~1/IBM/SQLLIB/BIN" "C:/PROGRA~1/IBM/SQLLIB/FUNCTION" "C:/PROGRA~1/IBM/SQLLIB/SAMPLES/REPL" "C:/Program Files/PuTTY/" "C:/Program Files/TortoiseSVN/bin" "C:/Program Files/Git/cmd" "C:/Users/lb/.emacs.d/emacs/bin" "C:/Users/lb/AppData/Local/Microsoft/WindowsApps" "C:/Users/lb/.dotnet/tools" "C:/Users/lb/AppData/Local/gitkraken/bin" "C:/flyway-7.11.2" "C:/Users/lb/.dotnet/tools" "C:/Users/lb/AppData/Local/Programs/VSCodium/bin" "C:/Gradle/gradle-8.0.2/bin" "C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin" "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin" "." "c:/emacs/libexec/emacs/29.1/x86_64-w64-mingw32"))
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-cycle-emulate-tab nil)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(package-selected-packages
   '(magit-delta mini-frame doom-modeline goto-chg doom-themes vs-light-theme vs-dark-theme nord-theme powershell forge kind-icon all-the-icons-completion all-the-icons-dired angular-mode anzu cape corfu crux csv-mode diff-hl diminish dogears easy-kill ef-themes embark-consult go-translate haskell-mode hydra js2-mode magit marginalia markdown-mode move-text orderless org-modern org-present plz remember-last-theme rg treesit-auto typescript-mode undo-tree vertico visual-fill-column web-mode which-key yaml-mode))
 '(tab-first-completion nil)
 '(tool-bar-mode nil)
 '(xref-show-xrefs-function 'consult-xref))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 98 :width normal :foundry "outline" :family "Cascadia Code"))))
 '(fixed-pitch ((t (:family "JetBrains Mono"))))
 '(fixed-pitch-serif ((t (:inherit default :weight semi-bold :family "JetBrains Mono"))))
 '(magit-tag ((t (:underline t))))
 '(tab-bar ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0)))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (4 . 4) :style flat-button) :underline (:color foreground-color :style line :position 0)))))
 '(tab-line ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0) :box (:line-width (4 . 4) :style flat-button)))))
 '(tab-line-tab ((t (:inherit tab-line :style flat-button) :underline (:color foreground-color :style line :position 0))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red"))))
 '(variable-pitch ((t (:family "JetBrains Mono")))))

(setq my/notes-path (expand-file-name "h:/notes/"))
(global-hl-line-mode +1)
(cd "c:/Projects/apollon")
(set-frame-height (selected-frame) 45)
(set-frame-width (selected-frame) 160)
(load-theme 'doom-acario-light)

(defun work/copy-flyway ()
  "Copy flywaymigration config file."
  (interactive)
  (let ((currDir (if (equal buffer-file-name nil)
                     (dired-current-directory)
                   (file-name-directory buffer-file-name))))
    (setq configFile (completing-read "Find flywaymigration config file: " (delete "." (delete ".." (directory-files-recursively "O:\\DatabaseManagement\\Apollon\\Clients" "\\.bat")))))
    (when (not (string-empty-p configFile))
      (copy-file configFile currDir))))

(defun work/copy-flyway-webportal ()
  "Copy flywaymigration config file."
  (interactive)
  (let ((currDir (if (equal buffer-file-name nil)
                     (dired-current-directory)
                   (file-name-directory buffer-file-name))))
    (setq configFile (completing-read "Find flywaymigration config file: " (delete "." (delete ".." (directory-files-recursively "O:\\DatabaseManagement\\Apollon\\Webportal" "\\.bat")))))
    (when (not (string-empty-p configFile))
      (copy-file configFile currDir))))

(defun work/apollon-repo-init-for-deployment ()
  "Copy flywaymigration config file."
  (interactive)
  (let ((currDir (if (equal buffer-file-name nil)
                     (dired-current-directory)
                   (file-name-directory buffer-file-name))))
      (copy-file "C:\\Deployment\\init.bat" currDir)))


(message "custom file loaded")
