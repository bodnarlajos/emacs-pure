;; -*- lexical-binding: t -*-
;; this file contains the static pieces of the custom.new.el

(custom-set-variables
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(highlight-current-line-globally t)
 '(highlight-current-line-whole-line t)
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tab-bar-close-button-show nil)
 '(tab-bar-new-button-show nil)
 '(tab-line-close-button-show nil)
 '(tab-line-new-button-show nil)
 '(tool-bar-mode nil)
 '(magit-diff-refine-hunk 'all)
 '(standard-indent 2))


(custom-set-faces
 '(header-line ((t (:inherit default :background nil :height 0.8))))
 '(org-fontify-todo-headline t)
 '(org-fontify-whole-heading-line t)
 '(mode-line ((t (:box (:line-width (1 . 1) :color "black" :style released-button)))))
 '(org-hide-leading-stars t)
 '(fringe ((t (:inherit default))))
 '(magit-section-highlight ((nil :inherit nil :background nil)))
 '(tab-bar ((t (:inherit mode-line-inactive :overline nil))))
 '(tab-bar-tab ((t (:inherit tab-bar :box (:line-width (2 . 2) :style flat-button) :overline nil :underline nil :weight bold))))
 '(tab-bar-tab-inactive ((t (:inherit mode-line-inactive))))
 '(fixed-pitch ((t (:inherit default))))
 '(fixed-pitch-serif ((t (:inherit default)))))

;; (defvar my/background (face-attribute 'default :background))
;; (set-face-attribute 'org-hide nil :foreground my/background :background my/background)

(defun my/tab-bar-tab-name-truncated ()
  "Generate tab name from the buffer of the selected window.
Truncate it to the length specified by `tab-bar-tab-name-truncated-max'.
Append ellipsis `tab-bar-tab-name-ellipsis' in this case."
  (let ((tab-name (buffer-name (window-buffer (minibuffer-selected-window)))))
    (if (< (length tab-name) tab-bar-tab-name-truncated-max)
        tab-name
      (propertize (truncate-string-to-width
                   tab-name tab-bar-tab-name-truncated-max nil nil
                   tab-bar-tab-name-ellipsis)
                  'help-echo tab-name))))

(defun my/tab-bar-tab-name-format-default (tab i)
  (let ((current-p (eq (car tab) 'current-tab)))
    (propertize
     (concat (if tab-bar-tab-hints (format " -[%d]- " i) "")
             (alist-get 'name tab)
             (or (and tab-bar-close-button-show
                      (not (eq tab-bar-close-button-show
                               (if current-p 'non-selected 'selected)))
                      tab-bar-close-button)
                 ""))
     'face (funcall tab-bar-tab-face-function tab))))

(provide 'my-custom)
