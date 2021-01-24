(require 'eyebrowse)
(with-eval-after-load 'eyebrowse
	(set-face-attribute 'eyebrowse-mode-line-active nil :foreground "red" :underline t :bold t)
	(setq eyebrowse-mode-line-separator " "
				eyebrowse-mode-line-style 'always
				eyebrowse-new-workspace t)
	(eyebrowse-mode))

(provide 'my-eyebrowse)
