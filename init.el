;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (package-initialize)

;; (message "%s" file-name-handler-alist)
;; (setq debug-on-error t)
(setq frame-title-format '("%b"))
(setq file-name-handler-alist nil)

(defvar bootstrap-version nil)

(defvar my/project-dir '("/home/lbodnar/Projects"))
(defvar my/notes-dir "/home/lbodnar/Documents/notes")

(cua-mode t)
(blink-cursor-mode 0)

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; (setq ido-case-fold nil)
;; (ido-mode 1)
;; (make-local-variable 'ido-decorations)
;; (setf (nth 2 ido-decorations) "\n")
;; ;; show any name that has the chars you typed
;; (setq ido-enable-flex-matching t)
;; ;; use current pane for newly opened file
;; (setq ido-default-file-method 'selected-window)
;; ;; use current pane for newly switched buffer
;; (setq ido-default-buffer-method 'selected-window)
;; ;; stop ido from suggesting when naming new file
;; (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)
;; (setq max-mini-window-height 0.5)

;; (fido-mode 1)

(let ((my-load-file
	 (expand-file-name (concat user-emacs-directory "progs"))))
    (add-to-list 'load-path my-load-file))
(require 'my-defun)

(require 'undo-tree)
(global-undo-tree-mode)
(recentf-mode)
(require 'my-keys)
(require 'my-setq-defaults)
(require 'my-helm)
(require 'company)
(global-company-mode t)
(dumb-jump-mode 1)
(show-paren-mode 1)

(my/dark-theme)

(require 'helm-ag)
(setq helm-ag-base-command "rg -S --no-heading --ignore-file /home/lbodnar/.emacs.d/rg-ignore")

(setq dumb-jump-selector 'helm)

(add-to-list 'exec-path "~/.local/bin")

(add-hook 'nxml-mode-hook 'my/long-line)
(add-hook 'json-mode-hook 'my/long-line)
(add-to-list 'auto-mode-alist '("\\.log.*\\'" . auto-revert-mode))
