;; -*- lexical-binding: t -*-

(defun my/open-file ()
  "Open project files if it is a project, otherwise find-file"
  (interactive)
  (if (vc-root-dir)
      (call-interactively 'project-find-file)
    (call-interactively 'find-file)))

(defun my/org-new-line ()
  "..."
  (interactive)
  (org-end-of-line)
  (org-meta-return))

(defun my/start-term ()
  "Start terminal"
  (interactive)
  (if (eq system-type 'windows-nt)
      (my/start-powershell)
    (ansi-term "/bin/zsh")))

(defun my/open/folder (folder)
  "Open a folder with explorer or nautilus"
  (interactive "DDirectory: ")
  (let ((prog (if (eq system-type 'windows-nt) "start" "xdg-open")))
    (shell-command (concat prog " " (expand-file-name folder)) nil nil)))

(defun my/open/terminal (folder)
  "Open a folder with explorer or nautilus"
  (interactive "DDirectory: ")
  (let ((prog (if (eq system-type 'windows-nt) "c:/users/lbodnar/scoop/shims/alacritty.exe" "qterminal")))
    (shell-command (concat prog " " (expand-file-name folder)) nil nil)))

(defun my/start-powershell ()
  "..."
  (interactive)
  (async-shell-command "powershell.exe"))

(defun my/open-notes ()
  "Open file from the notes directory"
  (interactive)			
  (if (find-file (concat my/notes-path (completing-read "Find a note: " (delete "." (delete ".." (directory-files my/notes-path))))))
      (message "Opening note...")
    (message "Aborting")))

(defun indent-buffer ()
  (interactive)			
  (save-excursion		
    (indent-region (point-min) (point-max) nil)))

(defun my/root-project-dir ()
  "Return with the project's dir or current dir or default dir"
  (if (vc-root-dir)
      (vc-root-dir)
    (if buffer-file-name
        (file-name-directory (buffer-file-name))
      default-directory)))

(defun consult-ripgrep-symbol-at-point ()
  "Seearch in files whose base name is the same as the current file's."
  (interactive)
  (minibuffer-with-setup-hook
      (lambda () (goto-char (1+ (minibuffer-prompt-end))))
    (consult-ripgrep (my/root-project-dir)
                     (if-let ((sap (symbol-at-point)))
                         (format "%s -- -g *" sap)
                       (user-error "Buffer is not visiting a file")))))
(defun consult-ripgrep-related-files ()
  "Seearch in files whose base name is the same as the current file's."
  (interactive)
  (minibuffer-with-setup-hook
      (lambda () (goto-char (1+ (minibuffer-prompt-end))))
    (consult-ripgrep (my/root-project-dir)
                     (if-let ((file (buffer-file-name)))
                         (format "%s -- -g %s*.*" (symbol-at-point) (file-name-base file))
                       (user-error "Buffer is not visiting a file")))))
(defun consult-ripgrep-files-in-directory (dir)
  "Seearch in files whose base name is the same as the current file's."
  (interactive "DDirectory: ")
  (minibuffer-with-setup-hook
      (lambda () (goto-char (1+ (minibuffer-prompt-end))))
    (consult-ripgrep dir " -- -g *.*")))

(defun consult-ripgrep-search-in-notes ()
  "Search in notes"
  (interactive)
  (consult-ripgrep-files-in-directory my/notes-dir))

(defun consult-ripgrep-search-in-temp-dir ()
  "Search in temp notes"
  (interactive)
  (consult-ripgrep-files-in-directory my/temp-dir))

(defun restrict-to-current-file ()
  (interactive)
  (if-let ((file (with-minibuffer-selected-window
                   (buffer-file-name))))
      ;; (message "file: %s" file)
      (save-excursion
        (goto-char (point-max))
        (insert " -- -g " (file-name-base file) "*.*"))
    (user-error "Buffer is not visiting a file")))

(defun my/start-magit ()
  "Deploy and start magit"
  (interactive)
  (straight-use-package 'magit)
  (call-interactively 'magit-status))

(defun my/kill-buffer ()
  "Kill the current buffer"
  (interactive)
  (kill-buffer (buffer-name (current-buffer))))

(defun repeatize (keymap)
  "Add `repeat-mode' support to a KEYMAP."
  (map-keymap
   (lambda (_key cmd)
     (when (symbolp cmd)
       (put cmd 'repeat-map keymap)))
   (symbol-value keymap)))

(defvar my/is-start-lsp nil "The lsp server was enabled")
(defun my/start-lsp ()
  "Start lsp server"
  (interactive)
  (unless my/is-start-lsp
    (setq my/is-start-lsp t)
    (require 'extra-lsp))
  (lsp))

(defvar my/is-enable-tree-sitter nil "Ide feature was enabled") 
(defun my/enable-tree-sitter ()
  "Enable ide feature for a mode"
  (unless my/is-enable-tree-sitter
    (require 'tree-sitter)
    (require 'tree-sitter-langs))
  (tree-sitter-mode +1))

(defun my/xah-select-line ()
  "Select current line. If region is active, extend selection downward by line.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2017-11-01"
  (interactive)
  (if (region-active-p)
      (progn
	(forward-line 1)
	(end-of-line))
    (progn
      (end-of-line)
      (set-mark (line-beginning-position)))))

(defun my/translate-current-line ()
  "Translate current line"
  (interactive)
  (my/xah-select-line)
  (gts-do-translate)
  (keyboard-quit))

(provide 'defuns)
