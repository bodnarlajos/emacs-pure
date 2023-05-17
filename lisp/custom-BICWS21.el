(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(csv-separators '("," ";" ":"))
 '(custom-safe-themes
   '("afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" default))
 '(desktop-base-file-name "~/.emacs.d/.cache/.emacs.desktop")
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-cycle-emulate-tab nil)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(package-selected-packages
   '(mini-frame doom-modeline goto-chg doom-themes vs-light-theme vs-dark-theme nord-theme powershell forge kind-icon all-the-icons-completion all-the-icons-dired angular-mode anzu cape corfu crux csv-mode diff-hl diminish dogears easy-kill ef-themes embark-consult go-translate haskell-mode hydra js2-mode magit marginalia markdown-mode move-text orderless org-modern org-present plz remember-last-theme rg treesit-auto typescript-mode undo-tree vertico visual-fill-column web-mode which-key yaml-mode))
 '(tab-first-completion nil)
 '(xref-show-xrefs-function 'consult-xref))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight regular :height 98 :width normal :foundry "outline" :family "Fira Code"))))
 '(fixed-pitch ((t (:family "JetBrains Mono"))))
 '(fixed-pitch-serif ((t (:inherit default :weight semi-bold :family "JetBrains Mono"))))
 '(tab-bar ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0)))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (4 . 4) :style flat-button) :underline (:color foreground-color :style line :position 0)))))
 '(tab-line ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0) :box (:line-width (4 . 4) :style flat-button)))))
 '(tab-line-tab ((t (:inherit tab-line :style flat-button) :underline (:color foreground-color :style line :position 0))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red"))))
 '(variable-pitch ((t (:family "JetBrains Mono")))))

(setq my/notes-path (expand-file-name "h:/notes/"))
(global-hl-line-mode +1)
(cd "c:/Projects/apollon")
(set-frame-height (selected-frame) 40)
(set-frame-width (selected-frame) 180)
(load-theme 'doom-one-light)

(message "custom file loaded")
