;; -*- lexical-binding: t -*-

(defun my/open-file ()
  "Open project files if it is a project, otherwise find-file"
  (interactive)
  (if (consult--project-root)
      (call-interactively 'project-find-file)
    (call-interactively 'find-file)))

(defun my/org-new-line ()
  "..."
  (interactive)
  (org-end-of-line)
  (org-meta-return))

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

(provide 'defuns)
