;; -*- lexical-binding: t -*-

;; package init
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/bodnarlajos/straight.el/master/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-check-for-modifications nil
      straight-use-package-by-default t
      use-package-always-defer t
      completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; utils
(straight-use-package 'rg)
(straight-use-package 'consult)
(straight-use-package 'which-key)
(straight-use-package 'crux)
(straight-use-package 'easy-kill)
(straight-use-package 'diff-hl)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)

;; completion
(straight-use-package 'diminish)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)
(straight-use-package 'corfu)
(straight-use-package 'vertico)
(straight-use-package 'cape)

;; programming packages
(straight-use-package 'csharp-mode)
(straight-use-package 'powershell-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'angular-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'web-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'go-translate)

;; package configurations

;; remove tramp after crux
(with-eval-after-load 'crux
  (when (featurep 'tramp)
    (tramp-unload-tramp)))

(add-hook 'csharp-mode-hook #'my/enable-tree-sitter)
(add-hook 'typescript-mode-hook #'my/enable-tree-sitter)
(add-hook 'javascript-mode-hook #'my/enable-tree-sitter)
(add-hook 'js2-mode-hook #'my/enable-tree-sitter)
(add-hook 'mhtml-mode-hook #'my/enable-tree-sitter)
(add-hook 'html-mode-hook #'my/enable-tree-sitter)
(add-hook 'css-mode-hook #'my/enable-tree-sitter)
(add-hook 'haskell-mode-hook #'my/enable-tree-sitter)
(add-hook 'json-mode-hook #'my/enable-tree-sitter)
(add-hook 'jsonc-mode-hook #'my/enable-tree-sitter)

(require 'consult)
(add-hook 'xref-backend-functions #'consult-ripgrep-symbol-at-point)

(vertico-mode +1)
(marginalia-mode +1)
(global-corfu-mode +1)
(which-key-mode +1)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-hook 'prog-mode-hook 'diff-hl-mode)

(setq corfu-cycle nil
      corfu-quit-at-boundary nil
      corfu-auto-prefix 2
      corfu-auto nil
      corfu-quit-no-match t
      vertico-count 13
      vertico-cycle t
      completion-styles '(orderless)
      cape-dabbrev-min-length 2
      vertico-resize t)

(defun my/setup-elisp ()
  (setq-local completion-at-point-functions
              '(elisp-completion-at-point
                cape-dabbrev
                cape-file)
              cape-dabbrev-min-length 2))

(setq completion-at-point-functions '(cape-line))
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)
(add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

(defvar consult--source-my-menu
  `(:name     "Quick menu item"
	      :narrow   ?f
	      :category 'buffer
	      :face     'font-lock-keyword-face
	      :default  t
	      :action (lambda (result) (call-interactively (cdr (assoc result my/menu-items))))
	      :items (lambda () (mapcar #'car my/menu-items)))
  "My menu items for `consult-buffer'.")

(add-to-list 'consult-buffer-sources 'consult--source-my-menu)

(consult-customize
 consult-line :prompt "Search: ")

(custom-set-variables
 '(xref-show-xrefs-function 'consult-xref))

(defcustom my/menu-items '(("Notes" . my/open-notes)
		           ("Git" . vc-dir)
                           ("Back" . 'consult-mark)
                           ("Eval region" . eval-region)
                           ("Magit start" . my/start-magit)
                           ("BackGlobal" . consult-global-mark)
                           ("Powershell" . my/start-powershell)
                           ("Lsp" . my/start-lsp)
                           ("Translate" . gts-do-translate)
                           ("Run" . execute-extended-command)) "My-config menu items" :type '(alist :key-type string :value-type function))

(consult-customize
 consult-line :prompt "Search: ")

(require 'go-translate)
(setq gts-translate-list '(("en" "hu")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-bing-engine) (gts-google-engine))
       :render (gts-buffer-render)))

(add-hook 'csharp-mode-hook (lambda ()
                              (setq compile-command "dotnet build")))

(with-eval-after-load 'smerge-mode
  (defun modi/enable-smerge-maybe ()
    "Auto-enable `smerge-mode' when merge conflict is detected."
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^<<<<<<< " nil :noerror)
        (smerge-mode 1))))
  (add-hook 'find-file-hook #'modi/enable-smerge-maybe :append)
  
  (defhydra hydra-smerge (:color pink
                                 :hint nil
                                 :pre (smerge-mode 1)
                                 ;; Disable `smerge-mode' when quitting hydra if
                                 ;; no merge conflicts remain.
                                 :post (smerge-auto-leave))
    "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
    ("n" smerge-next)
    ("p" smerge-prev)
    ("b" smerge-keep-base)
    ("u" smerge-keep-upper)
    ("l" smerge-keep-lower)
    ("a" smerge-keep-all)
    ("RET" smerge-keep-current)
    ("\C-m" smerge-keep-current)
    ("<" smerge-diff-base-upper)
    ("=" smerge-diff-upper-lower)
    (">" smerge-diff-base-lower)
    ("R" smerge-refine)
    ("E" smerge-ediff)
    ("C" smerge-combine-with-next)
    ("r" smerge-resolve)
    ("k" smerge-kill-current)
    ("q" nil "cancel" :color blue)))

(provide 'extra-packages)
