(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(completion-cycle-threshold 3)
 '(completions-detailed t)
 '(css-indent-offset 2)
 '(csv-separators '("," ";" ":"))
 '(cua-mode t)
 '(custom-safe-themes
   '("afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(dogears-ignore-modes
   '(git-commit-mode fundamental-mode exwm-mode helm-major-mode))
 '(eldoc-box-max-pixel-width 600)
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(fast-but-imprecise-scrolling t)
 '(global-auto-revert-non-file-buffers t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(kill-do-not-save-duplicates t)
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(recentf-save-file (expand-file-name "recentf" user-emacs-directory))
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(tab-first-completion nil)
 '(tool-bar-mode nil)
 '(tramp-remote-path
   '("/home/ubuntu/.ghcup/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
 '(xref-show-xrefs-function 'consult-xref))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code" :foundry "SAJA" :slant normal :weight regular :height 128 :width normal))))
 '(magit-tag ((t (:underline t))))
 '(tab-bar ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0)))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (4 . 4) :style flat-button) :underline (:color foreground-color :style line :position 0)))))
 '(tab-line ((t (:inherit variable-pitch :underline (:color foreground-color :style line :position 0) :box (:line-width (4 . 4) :style flat-button)))))
 '(tab-line-tab ((t (:inherit tab-line :style flat-button) :underline (:color foreground-color :style line :position 0))))
 '(undo-tree-visualizer-active-branch-face ((t (:foreground "red")))))

(load-theme 'doom-one)
