;; -*- lexical-binding: t -*-

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(straight-use-package 'tide)
(straight-use-package 'js2-mode)
;;(straight-use-package 'ng2-mode)

(add-hook 'js2-mode-hook #'setup-tide-mode)
;; configure javascript-tide checker to run after your default javascript checker
;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

;; ;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(setq-default typescript-indent-level 2)

;; ;; formats the buffer before saving
;; (add-hook 'typescript-mode-hook 
;; (add-hook 'before-save-hook 'tide-format-before-save)
;; configure jsx-tide checker to run after your default jsx checker
;; (flycheck-add-mode 'javascript-eslint 'web-mode)
;; (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; (add-hook 'typescript-mode-hook 'ng2-mode)
;; (add-hook 'typescript-mode-hook #'lsp)

(provide 'my-js)
