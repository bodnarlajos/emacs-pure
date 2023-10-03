;; -*- lexical-binding: t -*-

(use-package magit
  :config
  ;; (add-to-list 'project-switch-commands (magit-project-status "Magit"))
  (require 'magit-extras)
  (custom-set-faces
   '(magit-tag ((t (:underline t)))))
  (custom-set-variables
   '(magit-diff-refine-hunk 'all))
  (use-package magit-delta
    :ensure t
    :hook (magit-mode . magit-delta-mode))
  (message "Loaded Magit!")
  :defer 5
  :after (hydra)
  :commands (magit-project-status magit-status project-switch-project)
  :bind
  (("C-x g" . magit-status)
   ("C-x C-g" . magit-status))
  :init
  (message "Loading Magit!"))

(use-package go-translate
  :defer 5
  :config
  (setq gts-translate-list '(("de" "hu") ("en" "hu")))
  (setq gts-default-translator
        (gts-translator
         :picker (gts-prompt-picker)
         :engines (list (gts-bing-engine) (gts-google-engine))
         :render (gts-buffer-render)))
  :bind
  (("M-l t" . gts-do-translate)))

(provide 'expensive-packages)
