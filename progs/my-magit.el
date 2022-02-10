;; -*- lexical-binding: t -*-

(straight-use-package 'magit)

(defun my/magit-status ()
  "Open a magit directory."
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively #'magit-status)
    (delete-other-windows)))

(defun my/faster-magit ()
	"Magit without things"
	(remove-hook 'magit-diff-sections-hook 'magit-insert-xref-buttons)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-xref-buttons)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-headers)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-notes)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-tag)
	(remove-hook 'magit-revision-sections-hook 'magit-insert-revision-message)
	(remove-hook 'magit-section-highlight-hook 'magit-diff-highlight)
	(remove-hook 'magit-section-movement-hook 'magit-log-maybe-update-revision-buffer)
	(remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-rest)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-output)
	(remove-hook 'magit-status-sections-hook 'magit-insert-bisect-log)
	(remove-hook 'magit-status-sections-hook 'magit-insert-stashes)
	(remove-hook 'magit-status-sections-hook 'magit-insert-error-header)
	(remove-hook 'magit-status-sections-hook 'magit-insert-upstream-branch-header)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
	(setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11))
	(setq magit--default-directory my/project-dir)  
	(setq magit-section-initial-visibility-alist (quote ((untracked . hide) (stashes . hide)))))

(with-eval-after-load 'magit
	(add-hook 'magit-status-mode-hook 'my/faster-magit)
	(define-key magit-stash-mode-map (kbd "a") (lambda ()
																								(magit-stash-apply)
																								(magit-log-bury-buffer)
																								(magit-refresh)))
	(custom-set-faces 
	 '(magit-diff-hunk-heading ((t (:foreground "orange"))))))

(defun my/start/git ()
	"Open the magit and remove other windows"
	(interactive)
	(my/magit-status)
	(delete-other-windows))

(provide 'my-magit)
