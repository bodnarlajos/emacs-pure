;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (custom-set-variables
   '(magit-diff-refine-hunk 'all))
  (setq project-switch-commands '((project-find-file "Find file")
                                   (project-find-dir "Find directory")
                                   (magit-project-status "Magit")))
  :defer 5
  :after (hydra)
  :init (require 'magit-extras))

(use-package magit-delta
  :ensure t
  :hook (magit-mode . magit-delta-mode))

(use-package go-translate
  :config
  (setq gts-translate-list '(("de" "hu") ("en" "hu")))
  (setq gts-default-translator
        (gts-translator
         :picker (gts-prompt-picker)
         :engines (list (gts-bing-engine) (gts-google-engine))
         :render (gts-buffer-render))))

(provide 'expensive-packages)
