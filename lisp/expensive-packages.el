;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (require 'magit-extras)
  (require 'magit-delta)
  (custom-set-variables
   '(magit-diff-refine-hunk 'all))
  (setq project-switch-commands '((project-find-file "Find file")
                                  (project-find-dir "Find directory")
                                  (magit-project-status "Magit")))
  (message "Loaded Magit!")
  :defer 5
  :after (hydra)
  :bind
  (("C-x g" . magit-status)
   ("C-x C-g" . magit-status))
  :init
  (message "Loading Magit!"))

;; (use-package magit-delta
;;   :defer 5
;;   :ensure t
;;   :hook (magit-mode . magit-delta-mode))

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
