;; -*- lexical-binding: t -*-

(use-package remember-last-theme)
(use-package solo-jazz-theme)
(use-package zerodark-theme)
(use-package doom-themes)
(use-package ef-themes
  :straight (ef-themes :type git :host github :repo "protesilaos/ef-themes"))

(remember-last-theme-with-file-enable "~/.emacs.d/last-theme")

(provide 'my-themes)
