;; -*- lexical-binding: t -*-
;; this file contains the static pieces of the custom.new.el

(custom-set-variables
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(doom-modeline-buffer-file-name-style 'truncate-upto-project)
 '(doom-modeline-height 36)
 '(doom-modeline-mode t)
 '(highlight-current-line-globally t)
 '(highlight-current-line-whole-line t)
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tab-bar-close-button-show nil)
 '(tab-bar-new-button-show nil)
 '(tab-line-close-button-show nil)
 '(tab-line-new-button-show nil)
 '(tool-bar-mode nil)
 '(standard-indent 2))

(custom-set-faces
 '(tab-bar ((t (:inherit mode-line))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (2 . 2) :style flat-button)))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive))))
 '(tab-line ((t (:inherit mode-line))))
 '(tab-line-tab ((t (:inherit tab-line))))
 '(tab-line-tab-current ((t (:inherit tab-line-tab :box (:line-width (2 . 2) :style flat-button)))))
 '(tab-line-tab-inactive ((t (:inherit mode-line-inactive))))
 '(fixed-pitch ((t (:inherit default))))
 '(fixed-pitch-serif ((t (:inherit default)))))

(provide 'my-custom)
