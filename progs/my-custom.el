;; -*- lexical-binding: t -*-
;; this file contains the static pieces of the custom.new.el

(custom-set-variables
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(doom-modeline-height 36)
 '(standard-indent 2))

(custom-set-faces
 '(tab-bar ((t (:inherit mode-line))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive))))
 '(tab-line ((t (:inherit mode-line))))
 '(tab-line-tab ((t (:inherit tab-line))))
 '(tab-line-tab-current ((t (:inherit tab-line-tab))))
 '(tab-line-tab-inactive ((t (:inherit mode-line-inactive))))
 '(fixed-pitch ((t (:inherit default))))
 '(fixed-pitch-serif ((t (:inherit default)))))

(provide 'my-custom)
