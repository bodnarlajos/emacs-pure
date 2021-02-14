;; packages  helm helm-swoop helm-flx smex

(require 'helm-config)
(helm-mode 1)
(helm-flx-mode 1)

(setq helm-split-window-in-side-p t)

(add-to-list 'display-buffer-alist
             '("\\`\\*helm.*\\*\\'"
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

(setq helm-swoop-split-with-multiple-windows nil
        helm-swoop-split-direction 'split-window-vertically
        helm-swoop-split-window-function 'helm-default-display-buffer)


(setq helm-echo-input-in-header-line t)

(defvar bottom-buffers nil
  "List of bottom buffers before helm session.
    Its element is a pair of `buffer-name' and `mode-line-format'.")

(defun bottom-buffers-init ()
  (setq-local mode-line-format (default-value 'mode-line-format))
  (setq bottom-buffers
        (cl-loop for w in (window-list)
                 when (window-at-side-p w 'bottom)
                 collect (with-current-buffer (window-buffer w)
                           (cons (buffer-name) mode-line-format)))))


(defun bottom-buffers-hide-mode-line ()
  (setq-default cursor-in-non-selected-windows nil)
  (mapc (lambda (elt)
          (with-current-buffer (car elt)
            (setq-local mode-line-format nil)))
        bottom-buffers))


(defun bottom-buffers-show-mode-line ()
  (setq-default cursor-in-non-selected-windows t)
  (when bottom-buffers
    (mapc (lambda (elt)
            (with-current-buffer (car elt)
              (setq-local mode-line-format (cdr elt))))
          bottom-buffers)
    (setq bottom-buffers nil)))

(defun helm-keyboard-quit-advice (orig-func &rest args)
  (bottom-buffers-show-mode-line)
  (apply orig-func args))


(add-hook 'helm-before-initialize-hook #'bottom-buffers-init)
(add-hook 'helm-after-initialize-hook #'bottom-buffers-hide-mode-line)
(add-hook 'helm-exit-minibuffer-hook #'bottom-buffers-show-mode-line)
(add-hook 'helm-cleanup-hook #'bottom-buffers-show-mode-line)
(advice-add 'helm-keyboard-quit :around #'helm-keyboard-quit-advice)

(setq helm-display-header-line nil)

(defvar helm-source-header-default-background (face-attribute 'helm-source-header :background))
(defvar helm-source-header-default-foreground (face-attribute 'helm-source-header :foreground))
(defvar helm-source-header-default-box (face-attribute 'helm-source-header :box))

(defun helm-toggle-header-line ()
  (if (> (length helm-sources) 1)
      (set-face-attribute 'helm-source-header
                          nil
                          :foreground helm-source-header-default-foreground
                          :background helm-source-header-default-background
                          :box helm-source-header-default-box
                          :height 1.0)
    (set-face-attribute 'helm-source-header
                        nil
                        :foreground (face-attribute 'helm-selection :background)
                        :background (face-attribute 'helm-selection :background)
                        :box nil
                        :height 0.1)))


(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)

(defun helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                              `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

(defun my-helm-make-source (f &rest args)
  (nconc args '(:fuzzy-match t))
  (apply f args))

(advice-add 'helm-make-source :around 'my-helm-make-source)

;; garbage collections
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

(require 'smex)
(smex-initialize)

(defvar helm-smex-source--candidates nil)
(defvar helm-smex-source--cache (make-hash-table :test #'eq))

(defun helm-smex//score-no-cache (command)
  (or (cdr (car (cl-member (symbol-name command) smex-cache
                           :test #'string=)))
      0))

(defun helm-smex//score (command)
  (or (gethash command helm-smex-source--cache)
      (puthash command (helm-smex//score-no-cache command)
               helm-smex-source--cache)))

(defun helm-smex//compare-candidates (command-name1 command-name2)
  (> (helm-smex//score (intern-soft command-name1))
     (helm-smex//score (intern-soft command-name2))))

(defclass helm-smex-source (helm-source-sync)
  ((init
    :initform (lambda ()
                (setq helm-smex-source--candidates
                      (smex-convert-for-ido smex-cache))
                (clrhash helm-smex-source--cache)))
   (candidates :initform 'helm-smex-source--candidates)
   (match :initform 'helm-fuzzy-match)
   (filtered-candidates-transformer
    :initform (lambda (candidates source)
                (sort candidates #'helm-smex//compare-candidates)))
   (action
    :initform (lambda (command-name)
                (unwind-protect
                    (execute-extended-command current-prefix-arg
                                              command-name)
                  (smex-rank (intern command-name)))))))

(defun helm-smex/run ()
  (interactive)
  (helm :buffer "*helm-smex*"
        :sources (helm-make-source "Smex" helm-smex-source)))

(provide 'my-helm)
