(straight-use-package 'magit)

(defun my/magit-status ()
  "Open a magit directory."
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively #'magit-status)
    (delete-other-windows)))

(defun my/faster-magit ()
	"Magit without things"
	;; ;; revision
	(remove-hook 'magit-diff-sections-hook 'magit-insert-xref-buttons)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-xref-buttons)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-headers)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-notes)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-tag)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-message)
	(remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-rest)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-output)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-log)
  ;; (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent))

(defun my/magit-keys ()
	""
	(define-key magit-hunk-section-map [mouse-1] 'magit-diff-visit-file)
  (define-key magit-file-section-map [mouse-1] 'magit-diff-visit-file)
  (define-key magit-commit-section-map [mouse-1] 'magit-diff-show-or-scroll-up)
  (define-key magit-revision-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-status-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)

  (define-key magit-hunk-section-map (kbd "SPC") nil)
  (define-key magit-file-section-map (kbd "SPC") nil)
  (define-key magit-commit-section-map (kbd "SPC") nil)
  (define-key magit-revision-mode-map (kbd "SPC") nil)
  (define-key magit-status-mode-map (kbd "SPC") nil)
  (define-key magit-process-mode-map (kbd "SPC") nil)
  (define-key magit-blame-mode-map (kbd "SPC") nil)

  (define-key magit-log-mode-map (kbd "<C-tab>") 'other-window)
  (define-key magit-revision-mode-map (kbd "C-c C-c") 'magit-section-cycle-global)
  (define-key magit-status-mode-map (kbd "C-c C-c") 'magit-section-cycle-global)
  (define-key magit-log-mode-map (kbd "C-c C-c") 'magit-section-cycle-global))

(with-eval-after-load 'magit
	(add-hook 'magit-status-mode-hook 'my/faster-magit)
	(add-hook 'magit-status-mode-hook 'my/magit-keys))

(straight-use-package 'magit)
(setq magit-auto-revert-mode nil)
(setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11))
(setq magit--default-directory my/project-dir)  
(setq magit-section-initial-visibility-alist (quote ((untracked . hide) (stashes . hide))))

(provide 'my-magit)
