;; -*- lexical-binding: t -*-

(defvar terminal-in-windows "c:/users/lbodnar/scoop/shims/alacritty.exe")
(defvar terminal-in-linux "/home/lbodnar/.cargo/bin/alacritty")
(defvar lazygit-in-windows "c:/users/lbodnar/scoop/shims/lazygit.exe")
(defvar lazygit-in-linux "/home/lbodnar/.local/bin/lazygit")
(defvar /menu-items '(("Jump to minibuffer: M-e" . nil)
                      ("Open help file" . /open-help-file)
                      ("Set encoding" . set-buffer-file-coding-system)
                      ("Open with encoding" . revert-buffer-with-coding-system)
                      ("Magit" . /start-magit)
                      ("Start Ide mode" . /start-ide)
                      ("Calculator" . calculator)
                      ("Format xml" . /format-xml)
                      ("Translate" . /translate)
                      ("Git history for file/buffer" . magit-log-buffer-file)) "my menu items")

(defun /translate()
  "Translate text"
  (interactive)
  (require 'expensive-packages)
  (gts-do-translate))

(defun /format-xml ()
  "Format xml file with xmllint"
  (interactive)
  (let (())))

(defun /open-help-file ()
  "Open the help file in the config folder"
  (interactive)
  (find-file (concat user-emacs-directory "help.org")))

(defun /show-menu ()
  "Show menu items"
  (interactive)
  (let* ((selected (completing-read "Menu: " /menu-items))
         (command (cdr (assoc selected /menu-items))))
    (message "%s" selected)
    (when command
    (call-interactively command))))

(defun /start-ide ()
  "Start ide funcitonality"
  (interactive)
  (require 'extra-lsp)
  (when (file-exists-p (buffer-file-name))
    (message "Start current buffer: %s" (buffer-file-name))
    (revert-buffer nil t)))

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

(defun /switch-buffer ()
  "Switch buffer if it is a project"
  (interactive)
  (if (vc-root-dir)
      (call-interactively 'consult-project-buffer)
    (call-interactively 'consult-buffer)))

(defun /open-file ()
  "Open project files if it is a project, otherwise find-file"
  (interactive)
  (if (or (vc-root-dir) (and (featurep 'magit) magit--default-directory))
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
  (let ((prog (if (eq system-type 'windows-nt) "c:/users/lbodnar/scoop/shims/alacritty.exe" "gnome-terminal")))
    (shell-command (concat prog " " (expand-file-name folder)) nil nil)))

(defun my/start-powershell ()
  "..."
  (interactive)
  (with-editor-async-shell-command "powershell.exe"))

(defun /open-notes ()
  "Open file from the notes directory"
  (interactive)			
  (if (find-file (completing-read "Find a note: " (delete "." (delete ".." (directory-files-recursively my/notes-path "\\.org\\|\\.md\\|\\.txt")))))
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

(defun /start-magit ()
  "Deploy and start magit"
  (interactive)
  (require 'expensive-packages)
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
  (interactive)
  (call-interactively 'dogears-remember)
  (mark-whole-buffer))

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
  (let* ((datestr (format-time-string "%Y%m%d_%H%M%S.txt"))
         ($buf (generate-new-buffer (format "untitled_%s" datestr))))
    (switch-to-buffer $buf)
    (write-file (concat my/notes-path "/temp/" (buffer-name $buf)))
    (auto-save-visited-mode +1)
    ))

(defun my/new-empty-org-buffer ()
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

(defvar /ligth-theme 'doom-one-light "The ligth theme")
(defvar /dark-theme 'doom-one "The dark theme")

(defun /switch-theme ()
  "Change dark/light theme"
  (interactive)
  (let ((current (car custom-enabled-themes)))
    (disable-theme current)
    (if (equal current /dark-theme)
        (load-theme /ligth-theme)
      (load-theme /dark-theme))))

(defvar /big-font-size 120 "the font size if the resolution is high")
(defvar /normal-font-size 98 "the font size if the resolution is high")

(defun /change-font-bigger ()
  "Change the font to bigger size"
  (interactive)
  (let ((currFontSize (face-attribute 'default :height)))
    (if (equal currFontSize /normal-font-size)
        (set-face-attribute 'default nil :height /big-font-size)
      (set-face-attribute 'default nil :height /normal-font-size))))

(add-hook 'minibuffer-setup-hook (lambda ()
                                   (buffer-face-set 'default)))

(defun back-to-indentation-or-beginning ()
  (interactive)
   (if (= (point) (progn (back-to-indentation) (point)))
       (beginning-of-line)))

(provide 'defuns)
