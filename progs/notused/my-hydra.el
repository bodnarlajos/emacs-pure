;; -*- lexical-binding: t -*-

(straight-use-package 'hydra)

(global-unset-key (kbd "C-l"))
(global-set-key (kbd "C-l") 'my/command-menu/body)

(defun start-hydra ()
  "T."
  (interactive)
  (my/command-menu/body))

(with-eval-after-load 'hydra
  (defvar hydra-latest-body nil)
  (defun my/hydra-back ()
    "T."
    (interactive)
    (when hydra-latest-body
      (let ((go-to-body hydra-latest-body))
				(setq hydra-latest-body nil)
				(call-interactively go-to-body))))	
  (defhydra my/edit-menu (:hint nil)
    "
    ^Edit^             		  ^Rectangle^      ^Highlight^
    ^^^^^^------------------^^^^^^^^^^^------^^^^^^^^^^^-------------------------------------
    _r_: replace       		  _o_: open rect   _h_: highlight at point
    _p_: paste-from-reg		  _k_: kill rect   _H_: remove highlight
    _s_: save-to-reg   		  _c_: copy rect

    _<tab>_: back to the previous
    "
    ("r" query-replace :exit t)
    ("p" insert-register :exit t)
    ("h" highlight-symbol-at-point :exit t)
    ("H" hi-lock-mode :exit t)
    ("s" copy-to-register :exit t)
    ("k" kill-rectangle :exit nil)
    ("o" open-rectangle :exit nil)
    ("c" yank-rectangle :exit nil)
    ("<tab>" my/hydra-back :exit t)
    ("q" nil "quit" :exit t))
  
  (defhydra my/tools-menu (:hint nil)
    "
    ^Open^             ^Action^           ^Folding^
    ^^^^^^-------------^^^^^^^^-----------^^^^^^^^^--------------------
    _b_: bookmarks     _c_: comment       _f s_: show
    _n_: open note     _u_: undo-tree     _f h_: hide
    _r_: recent files  _m_: magit
    _p_: project       _i_: indent
    
    _<tab>_: back to the previous
    "
    ("b" bookmark-jump :exit t)
    ("f s" yafolding-show-element :exit t)
    ("f h" yafolding-hide-element :exit t)
    ("c" comment-or-uncomment-region :exit t)
    ("n" (progn
					 (my/load-my "defun")
					 (my/open-notes)) :exit t)
    ("i" indent-buffer :exit t)
    ("u" undo-tree-visualize :exit t)
    ("r" ido-recentf-open :exit t)
		("p" (progn
					 (my/load-my "projectile")
					 (projectile-mode)
					 (projectile-switch-project)) :exit t)
		("m" (progn
					 (my/load-my "magit")
					 (my/magit-status)) :exit t)
		("<tab>" my/hydra-back :exit t)
		("q" nil "quit" :exit t))
  
  (defhydra my/move-menu (:hint nil)
    "
    ^Jump^
    ^^^^^^-----------------------------
    _g_    : go      _j_: mark-ring
    _b_    : back    _f_: swiper
    _<tab>_: back to the previous
    "
    ("g" (progn
					 (my/load-my "jump")
					 (dumb-jump-go)) :exit t)
    ("b" (progn
					 (my/load-my "jump")
					 (dumb-jump-back)) :exit nil)
    ("j" set-mark-command :exit t)
    ("f" isearch-forward :exit t)

    ("<tab>" my/hydra-back :exit t)
    ("q" nil "quit" :exit t))
  
  (defhydra my/command-menu (:hint nil)
    "
  ^Menu^        ^Command^      ^Buffers^    ^Things^
  ^^^^^^--------^^^^^^^^^------^^^^^^^^^----^^^^^^^^^^^^-----
  _m_: move   _o_: open file   _bb_: list   _v_: select  
  _e_: edit   _d_: dupl.line   _bk_: kill   _u_: undo 
  _t_: tools  _w_: togglewin   _br_: revert _r_: redo 
            _j_: jumpTo     _l_: recenter
  "
    ("w" window-toggle-side-windows :exit t)
    ("d" duplicate-line :exit t)
    ("v" cua-set-mark :exit t)
    ("o" find-file :exit t)
    ("j" set-mark-command :exit t)
    ("u" undo-tree-undo :exit nil)
    ("r" undo-tree-redo :exit nil)
    ("l" recenter :exit t)
    ("bb" switch-to-buffer :exit t)
    ("bk" kill-buffer :exit t)
    ("br" revert-buffer :exit t)
    ("m" (progn
					 (setq hydra-latest-body 'my/command-menu/body)
					 (my/move-menu/body)) :exit t)
    ("e" (progn
					 (setq hydra-latest-body 'my/command-menu/body)
					 (my/edit-menu/body)) :exit t)
    ("t" (progn
					 (setq hydra-latest-body 'my/command-menu/body)
					 (my/tools-menu/body)) :exit t)
    ("q" nil "quit" :color blue :exit t)
    ("<f6>" nil "quit" :color blue :exit t)))

(my/installed "hydra")
