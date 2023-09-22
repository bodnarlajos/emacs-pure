;; -*- lexical-binding: t -*-

(use-package magit
  :config
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
  :commands (magit-project-status magit-status)
  :bind
  (("C-x g" . magit-status)
   ("C-x C-g" . magit-status))
  :init
  (setq project-switch-commands '((project-find-file "Find file")
                                  (project-find-dir "Find directory")
                                  (magit-project-status "Magit")))
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
