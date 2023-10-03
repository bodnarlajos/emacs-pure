(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(csv-separators '("," ";" ":"))
 '(cua-mode t)
 '(custom-safe-themes
   '("afa47084cb0beb684281f480aa84dab7c9170b084423c7f87ba755b15f6776ef" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(eldoc-documentation-strategy 'eldoc-documentation-compose)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(magit-diff-refine-hunk 'all)
 '(next-error-recenter '(4))
 '(org-adapt-indentation 'headline-data)
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(tab-always-indent 'complete)
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

(load-theme 'doom-one-light)
