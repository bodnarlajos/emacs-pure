(leaf emacs
  :config
  (fido-mode t))

(leaf haskell-mode
  :ensure t)

(leaf powershell-mode
  :ensure t)

(leaf consult
  :ensure t)

(leaf doom-themes
  :ensure t)

(leaf undo-tree
  :ensure t
  :init
  (global-undo-tree-mode t)
  (diminish 'undo-tree-mode)
  :bind (("C-z" . undo-tree-undo)
         ("C-y" . undo-tree-redo))
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo/")))
  (custom-set-faces
   '(undo-tree-visualizer-active-branch-face ((t (:foreground "red")))))
  (add-to-list 'display-buffer-alist
	       '("\\*undo-tree\\*"
	         (display-buffer-reuse-window display-buffer-in-side-window)
	         (window-width . 60)
	         (side . right)
                 (slot . 2))))

(leaf rg
  :ensure t)

(leaf magit
  :ensure t
  :config
  (custom-set-variables
   '(magit-diff-refine-hunk 'all))
  :after (hydra)
  :init (require 'magit-extras))

(provide 'without-gui)
