;; -*- lexical-binding: t -*-
;; this file contains the static pieces of the custom.new.el

(custom-set-variables
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(standard-indent 2)
 '(tab-bar-new-tab-choice "*scratch*"))

(custom-set-faces
 '(fixed-pitch ((t (:inherit default))))
 '(fixed-pitch-serif ((t (:inherit default))))
 '(tab-bar ((t (:inherit mode-line))))
 '(tab-bar-tab ((t (:inherit tab-bar :height 1.2)))))

(provide 'my-custom)
