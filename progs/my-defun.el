(require 'cl-lib)
(straight-use-package 'ace-window)

(defun my/select-window ()
	"select a window"
	(interactive)
	(ace-select-window))
(defun my/swap-window ()
	"swap a window"
	(interactive)
	(ace-swap-window))

(defun my/copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun my/ffap ()
	"ffap"
	(interactive)
	(let ((url (ffap-url-at-point)))
		(browse-url url)))

(defun my/xah-new-empty-buffer ()
  "Create a new empty buffer."
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))

(defun my/add-dev-hook (fv)
	"Add or run a function when dev mode is active or not"
	(if my/dev-env
			(funcall fv)
		(add-hook 'my/dev-hook fv)))

(defun my/revert-current-buffer ()
	"Revert the current buffer without prompt"
	(interactive)
	(let ((currBuffPath (buffer-file-name (current-buffer))))
		(kill-current-buffer)
		(find-file currBuffPath)))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))

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

(defun my/comment-uncomment-line ()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))

(defun my/git-only ()
  "Open the magit and remove other windows"
  (interactive)
	(require 'my-magit)
	(my/magit-status)
	(delete-other-windows))

(defun my/menu-smex ()
	"T."
	(interactive)
	(setq ido-selected "Run Command")
	(setq ido-text "Run Command")
	(ido-exit-minibuffer))

(defun my/menu-base ()
	"Base menu"				
	(interactive)			
	(let ((replaceString "Replace string")
				(recentfFiles "Recent files")
				(rg "Rg search")
				(rgCurrent "Rg search current dir")
				(jumpTo "Jump to ->")
				(revertBuffer "Revert buffer")
				(runCommand "Run Command")
				(backTo "<- Back to")
				(magit "Git")
				(openNotes "Notes ...")
				(findnamedired "Find file")
				(vcdir "Version control")
				(development "Start development!")
				(elScrn "Screen new")
				(elScrnNext "Screen next")
				(flymakeList "Flymake list")
				(longLines "Long lines")
				(projectFindFile "Project find file")
				(loadLayot "Load layout")
				(load-desktop "Load desktop")
				(xahBuffer "New buffer")
				(projectCompile "Project compile"))
		(let ((ido-list (list recentfFiles runCommand revertBuffer load-desktop rg rgCurrent backTo development xahBuffer openNotes magit vcdir longLines replaceString jumpTo flymakeList projectFindFile elScrn elScrnNext projectCompile findnamedired)))
			(let ((res (selectrum-completing-read "Action: " ido-list)))
				(cond				
				 ((string-equal res replaceString) (call-interactively 'query-replace))
				 ((string-equal res projectFindFile) (call-interactively 'project-find-file))
				 ((string-equal res recentfFiles) (call-interactively 'ido-recentf-open))
				 ((string-equal res projectCompile) (call-interactively 'project-compile))
				 ((string-equal res openNotes) (call-interactively 'my/open-notes))
				 ((string-equal res longLines) (call-interactively 'my/long-line))
				 ((string-equal res rg) (call-interactively 'rg))
				 ((string-equal res load-desktop) (call-interactively 'desktop-read))
				 ((string-equal res rgCurrent) (call-interactively 'consult-ripgrep))
				 ((string-equal res elScrn) (call-interactively 'my/elscreen-new))
				 ((string-equal res elScrnNext) (call-interactively 'my/elscreen-next))
				 ((string-equal res revertBuffer) (call-interactively 'revert-buffer))
				 ((string-equal res loadLayot) (call-interactively 'purpose-load-window-layout))
				 ((string-equal res runCommand) (call-interactively 'execute-extended-command))
				 ((string-equal res findnamedired) (call-interactively 'find-name-dired))
				 ((string-equal res magit) (call-interactively 'my/git-only))
				 ((string-equal res vcdir) (call-interactively 'vc-dir))
				 ((string-equal res flymakeList) (call-interactively 'consult-flymake))
				 ((string-equal res development) (call-interactively 'my/start-dev-env))
				 ((string-equal res jumpTo) (call-interactively 'my/dumb-jump-go))
				 ((string-equal res xahBuffer) (call-interactively 'my/xah-new-empty-buffer))
				 ((string-equal res backTo) (call-interactively 'xref-pop-marker-stack)))))))

(defun my/dumb-jump-go ()
	"Initialize and jump"
	(interactive)
	(when (not (featurep 'dumb-jump))
		(straight-use-package 'dumb-jump))
	(dumb-jump-go))

(defun my/elscreen-new ()
	"Initialize the elscreen and create a new empty screen"
	(interactive)
	(when (not (featurep 'elscreen))
		(straight-use-package 'elscreen)
		(elscreen-start))
	(elscreen-create))

(defun my/elscreen-next ()
	"Jump to the next elscreen page"
	(interactive)
	(when (featurep 'elscreen)
		(elscreen-next)))

(defun my/start-dev-env ()
	"T."
	(interactive)
	(require 'my-dev)
	(my/revert-current-buffer))

(defun ido-recentf-open ()
	"Use `ido-completing-read' to find a recent file."
	(interactive)			
	(if (find-file (selectrum-completing-read "Find recent file: " recentf-list))
			(message "Opening file...")
		(message "Aborting")))

(defun my/open-notes ()
	"Open file from the notes directory"
	(interactive)			
	(if (find-file (concat my/notes-dir (selectrum-completing-read "Find a note: " (delete "." (delete ".." (directory-files my/notes-dir))))))
			(message "Opening note...")
		(message "Aborting")))

(defun my/long-line ()
	"Open long lines plugins"
	(interactive)			
	(let ((ep (line-end-position)))
		(when (>= ep 1000)
			(so-long)			
			(require 'longlines)
			(longlines-mode +1))))

(defun my/kill-buffer-close-window ()
	"Kill the current buffer and close the window"
	(interactive)
	(kill-buffer)
	(delete-window))

(defun my/dark-theme ()
	"T."
	(interactive)
	(straight-use-package 'color-theme-sanityinc-tomorrow)
	(load-theme 'sanityinc-tomorrow-eighties)
	(my/set-font))

(defun my/light-theme ()
	"T."
	(interactive)
	(straight-use-package 'color-theme-sanityinc-tomorrow)
	(load-theme 'sanityinc-tomorrow-day)
	(my/set-font))

(defun my/load (filename)
	"T."							
	(let ((my-load-file
				 (expand-file-name (concat "progs/my-" filename ".el") user-emacs-directory)))
		(load my-load-file)))

(defun my/add-load-path (dir)
	"T."							
	(let ((my-load-file
				 (expand-file-name (concat "progs/" dir) user-emacs-directory)))
		(add-to-list 'load-path my-load-file)))

(defun indent-buffer ()
	(interactive)			
	(save-excursion		
		(indent-region (point-min) (point-max) nil)))

(defun duplicate-line()
	"T."							
	(interactive)			
	(move-beginning-of-line 1)
	(kill-line)				
	(yank)						
	(open-line 1)			
	(next-line 1)			
	(yank))						

(defun move-line-down ()
	(interactive)
	(let ((col (current-column)))
		(save-excursion
			(forward-line)
			(transpose-lines 1))
		(forward-line)
		(move-to-column col)))

(defun move-line-up ()
	(interactive)
	(let ((col (current-column)))
		(save-excursion
			(forward-line)
			(transpose-lines -1))
		(forward-line -1)
		(move-to-column col)))

(defun parent-directory (dir)
	(unless (equal "/" dir)
		(file-name-directory (directory-file-name dir))))

(defun log-highlight ()
	"T."							
	(interactive)			
	(highlight-lines-matching-regexp "\\(\\[Debug.*\\]\\)" 'hi-blue-b)
	(highlight-lines-matching-regexp "\\(\\[Error.*\\]\\)" 'hi-red-b)
	(highlight-lines-matching-regexp "\\(Exception.*\\)" 'hi-red-b)
	(highlight-lines-matching-regexp "\\(\\[Info.*\\]\\)" 'hi-green-b))

(defun open-note ()	
	"T."							
	(interactive)			
	(find-file "~/note.org"))

(defun switch-to-previous-buffer ()
	"Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
	(interactive)			
	(switch-to-buffer (other-buffer (current-buffer) 1)))

(defun crux-smart-open-line (arg)
	"Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode.
With a prefix ARG open line above the current line."
	(interactive "P")	
	(if arg						
			(crux-smart-open-line-above)
		(move-end-of-line nil)
		(newline-and-indent)))

(defun crux-smart-open-line-above ()
	"Insert an empty line above the current line.
Position the cursor at its beginning, according to the current mode."
	(interactive)			
	(move-beginning-of-line nil)
	(insert "\n")			
	(if electric-indent-inhibit
			;; We can't use `indent-according-to-mode' in languages like Python,
			;; as there are multiple possible indentations with different meanings.
			(let* ((indent-end (progn (crux-move-to-mode-line-start) (point)))
						 (indent-start (progn (move-beginning-of-line nil) (point)))
						 (indent-chars (buffer-substring indent-start indent-end)))
				(forward-line -1)
				;; This new line should be indented with the same characters as
				;; the current line.
				(insert indent-chars))
		;; Just use the current major-mode's indent facility.
		(forward-line -1)
		(indent-according-to-mode)))

(defun kill-buffer-if-run (bufferName)
	"T."							
	(let ((bl (buffer-list)))
		(while bl				
			(when (string-equal (buffer-name (car bl)) bufferName)
				(kill-buffer (car bl))
				(setq bl nil))
			(setq bl (cdr bl)))))

(defun crux-smart-kill-line ()
	"Kill to the end of the line and kill whole line on the next call."
	(interactive)			
	(let ((orig-point (point)))
		(move-end-of-line 1)
		(if (= orig-point (point))
				(kill-whole-line)
			(goto-char orig-point)
			(kill-line))))

(defvar my/temp-file-path "/tmp/")
(defvar my/temp-buffer-prefix "#:")
(defun my/find-file-with-temp (filepath)
	"T."							
	(interactive "FOpen file: ")
	(let ((temp-path (concat my/temp-file-path (string-trim-left filepath "^\/"))))
		(message "%s" temp-path)
		(async-shell-command (concat "mkdir -p " (file-name-directory temp-path) "; cat " filepath " > " temp-path))
		(find-file (concat temp-path))))

(defun my/view-file (filepath)
	"Open file async, it's just readonly and you can't revert"
	(interactive "FOpen file: ")
	(let ((temp-buffer-name (generate-new-buffer-name (concat my/temp-buffer-prefix filepath) (concat my/temp-buffer-prefix filepath))))
		(switch-to-buffer temp-buffer-name)
		(async-shell-command (concat "cat " filepath) temp-buffer-name)))

(defun my/revert-view-file ()
	"Revert a view-file"
	(interactive)			
	(let* ((buffertitle (buffer-name))
				 (bufferpath (string-remove-prefix my/temp-buffer-prefix buffertitle)))
		(if (string-prefix-p my/temp-buffer-prefix buffertitle)
				(progn			
					(message "%s" bufferpath)
					(my/view-file bufferpath))
			(message "It's not a view-file: %s" buffertitle))))

(defun my/view-file-at-line ()
	"Open a file async based on the current line"
	(interactive)			
	(let ((filepath (string-trim (buffer-substring (line-beginning-position) (line-end-position)))))
		(if (file-exists-p filepath)
				(my/view-file filepath)
			(message "It's not a file: %s" filepath))))

(provide 'my-defun)	
