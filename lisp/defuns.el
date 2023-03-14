;; -*- lexical-binding: t -*-

(defvar terminal-in-windows "c:/users/lbodnar/scoop/shims/alacritty.exe")
(defvar terminal-in-linux "/home/lbodnar/.cargo/bin/alacritty")
(defvar lazygit-in-windows "c:/users/lbodnar/scoop/shims/lazygit.exe")
(defvar lazygit-in-linux "/home/lbodnar/.local/bin/lazygit")

(defun position-to-kill-ring ()
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive)
  (kill-new
   (format "%s::%d" (buffer-file-name) (save-restriction
                                         (widen) (line-number-at-pos)))))

(defun position-to-kill-ring-for-org ()
  "Copy to the kill ring a string in the format \"file-name:line-number\"
for the current buffer's file name, and the line number at point."
  (interactive)
  (kill-new
   (format "[[%s::%d]]" (buffer-file-name) (save-restriction
                                             (widen) (line-number-at-pos)))))

(defun my/print-file-name ()
  "Print the current file-name to the minibuffer and put it to the kill-ring"
  (interactive)
  (let ((fn (buffer-file-name (current-buffer))))
    (message "%s" fn)
    (kill-new fn)))

(defun my/print-buffer-name ()
  "Print the current file-name to the minibuffer and put it to the kill-ring"
  (interactive)
  (let ((fn (buffer-name (current-buffer))))
    (message "%s" fn)
    (kill-new fn)))

(defun my/get-terminal ()
  "Get the system terminal path"
  (if (eq system-type 'windows-nt) terminal-in-windows terminal-in-linux))

(defun my/get-lazygit ()
  "Get the system's lazygit path"
  (if (eq system-type 'windows-nt) lazygit-in-windows lazygit-in-linux))

(defun my/eval-region ()
  "Eval a region and deactivate mark"
  (interactive)
  (eval-region (region-beginning) (region-end))
  (deactivate-mark))

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

(defun my/start-lazygit ()
  "Start terminal"
  (interactive)
  (let ((term-exe (my/get-terminal))
        (lazygit-exe (my/get-lazygit))
        (proj-root-dir (my/root-project-dir)))
    (async-shell-command (concat term-exe " -e " lazygit-exe " -p " proj-root-dir) nil nil)))

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
  (with-editor-async-shell-command "powershell.exe"))

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
                         (format "%s -- -g *.*" sap)
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
  (consult-ripgrep-files-in-directory my/notes-path))

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
  (use-package hydra)
  (use-package magit)
  (require 'magit-extras)
  (call-interactively 'magit-project-status))


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

(defun my/select-all ()
  "Select all"
  (push-global-mark)
  (mark-whole-buffer))

(defun my/light-theme ()
  "Light theme"
  (interactive)
  (disable-theme 'deeper-blue))

(defun my/dark-theme ()
  "Dark theme"
  (interactive)
  (load-theme 'deeper-blue))

(defun my/toggle-word-wrap ()
  "Toggle the word-wrap functionality"
  (interactive)
  (if (bound-and-true-p visual-line-mode)
      (progn
        (visual-line-mode -1)
        (horizontal-scroll-bar-mode +1)
        (scroll-bar-mode +1))
    (progn
      (visual-line-mode +1)
      (horizontal-scroll-bar-mode -1)
      (scroll-bar-mode -1))))

(defun my/new-empty-buffer ()
  "Create a new empty buffer."
  (interactive)
  (require 'calendar)
  (require 'org)
  (let* ((datestr (format-time-string "%Y%m%d_%H%M%S.org"))
         ($buf (generate-new-buffer (format "untitled_%s" datestr))))
    (switch-to-buffer $buf)
    (funcall 'org-mode)
    (write-file (concat my/notes-path "/temp/" (buffer-name $buf)))
    (auto-save-visited-mode +1)
    ))

(defun file-size (filename)
  "Return size of file FILENAME in bytes.
    The size is converted to float for consistency.
    This doesn't recurse directories."
  (float
   (file-attribute-size			; might be int or float
    (file-attributes filename))))
(defun file-size-total (filename-list)
  "Return the sum of sizes of FILENAME-LIST in bytes."
  (apply '+
	 (mapcar 'file-size
		 filename-list)))
(defun dired-size-of-marked-files ()
  "Print the total size of marked files in bytes."
  (interactive)
  (message "%.0f"
	   (file-size-total (dired-get-marked-files))))

(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn 
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                 (match-string 1))))))

(provide 'defuns)
