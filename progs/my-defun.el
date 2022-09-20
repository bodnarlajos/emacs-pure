;; -*- lexical-binding: t -*-

(defun my/open/my-config ()
	"Open my-config group configuration"
	(interactive)
	(customize-group 'my/configs))

(defun my/start/emacs ()
	"T."
	(interactive)
	(start-process "emacs" nil "C:/ProgramData/emacs-native/bin/runemacs.exe"))

(defun my/start/git-gui ()
	"T."
	(interactive)
	(let ((currDir default-directory))
		(call-interactively 'cd)
		(start-process "gitgui" nil my/const/git-gui-exe--path "gui")
		(cd currDir)))

(defun my/start/gitk ()
	"T."
	(interactive)
	(let ((currDir default-directory))
		(call-interactively 'cd)
		(start-process "gitk" nil my/const/gitk-exe--path)
		(cd currDir)))

(defun my/switch-to-buffer ()
	"Switch to the buffer or switch to buffer inside a project"
	(interactive)
	(let ((currProject (project-root (project-current))))
		(if currProject
				(call-interactively 'project-switch-to-buffer)
			(call-interactively 'switch-to-buffer))))

(defun my/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard.It's a prelude code ..."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun my/delete-this-file ()
	"Delete the current buffer and the file"
	(interactive)
	(let ((buffername (buffer-file-name)))
		(kill-buffer (current-buffer))
		(delete-file buffername)))

(defun my/check/start-with-in-list (str thelist)
	"T."
	(let ((inlist thelist)
				(result nil))
		(while inlist
			(when (string-prefix-p (car inlist) str)
				(progn
					(setq result (car inlist))
					(setq inlist nil)))
			(setq inlist (cdr inlist)))
		result))

(defun my/make-frame-readonly ()
	"Make the frame readnoly
  It means that you can't switch the buffer"
	(interactive)
	(let ((buffname (concat "RO" (string-replace "." "" (string-replace "-" "" (buffer-name (current-buffer)))))))
		;; (message "%s" buffname)
		(make-frame '((name . "RO buffer") (minibuffer . nil) (mode-line-format . nil)))))

(defun run-if-monitor (monitor1 monitor2)
	"Retrive which monitor is in use"
	(let ((dp (car (frame-position (selected-frame)))))
		(message "%s" dp)
		(if (< dp -20)
				(funcall monitor2)
			(funcall monitor1))))

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

(defun my/ffap-url ()
	"ffap"
	(interactive)
	(let ((url (ffap-url-at-point)))
		(browse-url url)))

(defun my/xah-new-empty-buffer-org ()
	"Create a new empty buffer."
	(interactive)
	(require 'calendar)
	(let (($buf (generate-new-buffer "untitled")))
		(switch-to-buffer $buf)
		(funcall initial-major-mode)
		(setq buffer-offer-save t)
		(org-mode)
		(auto-save-mode +1)
		(let ((datestr (format-time-string "%Y%m%d_%H%M%S")))
			(write-file (concat my/temp-dir "/" (buffer-name) "." datestr ".org")))
		$buf
		))

(defun my/xah-new-empty-buffer ()
	"Create a new empty buffer."
	(interactive)
	(require 'calendar)
	(let (($buf (generate-new-buffer "untitled")))
		(switch-to-buffer $buf)
		(funcall initial-major-mode)
		(setq buffer-offer-save t)
		$buf
		(auto-save-mode +1)
		(let ((datestr (format-time-string "%Y%m%d_%H%M%S")))
			(write-file (concat my/temp-dir "/" (buffer-name) "." datestr ".txt")))
		))

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

(defun my/menu-item-formatter (itemName signer)
	"."
	(format "[%s]-| %s" signer itemName))

(defun my/menu-item (itemName)
	"."
	(my/menu-item-formatter itemName " "))

(defun my/menu-item-for-program (itemName)
	"."
	(my/menu-item-formatter itemName "!"))

;; (defvar my-menu-bar-menu (make-sparse-keymap "Mine"))
;; (define-key global-map [menu-bar my-menu] (cons "Mine" my-menu-bar-menu))

;; (mapcar (lambda (i)
;; 					(define-key my-menu-bar-menu [(cdr i)]
;; 											'(menu-item (car i) (cdr i) :help (car i)))
;; 					) my/menu-items)

(defun my/start/menu ()
	"Open my/menu-items"
	(interactive)
	(message "start edebug")
	(let ((menulist (mapcar 'car my/menu-items)))
		(let ((result (completing-read "Menu: " menulist)))
			(message "result: %s" result)
			(call-interactively (cdr (assoc result my/menu-items))))))

(defun my/open-note-daily ()
	"Open the daily notes"
	(interactive)
	(org-agenda nil "a"))

(defun my/open-notes ()
	"Open file from the notes directory"
	(interactive)			
	(if (find-file (concat my/notes-dir (completing-read "Find a note: " (delete "." (delete ".." (directory-files my/notes-dir))))))
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

(defun my/long-line-wrap ()
	"Wrap long lines to window-width char long string"
	(interactive) 
	(let ((isreadonly buffer-read-only))
		(when isreadonly
			(read-only-mode -1))
		(save-excursion
			(replace-regexp (format ".\\\{%d\\}" (- (window-width) 8)) "\\\& ┃\n" nil (point-min) (point-max)))
		(when isreadonly
			(read-only-mode +1))))

(defun my/long-line-wrap-fix ()
	"Wrap long lines to window-width char long string"
	(interactive)
	(save-excursion
		(query-replace-regexp ".\\\{120\\}" "\\\& ┃\n" nil (point-min) (point-max))))

(defun my/kill-buffer-close-window ()
	"Kill the current buffer and close the window"
	(interactive)
	(bury-buffer)
	(delete-window))

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
		(transpose-lines 1)
		(forward-line -2)
		(move-to-column col)))

(defun my/select-all ()
	"T."
	(interactive)
	(cua-exchange-point-and-mark nil)
	(mark-whole-buffer))

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

(defun my/open/init.el ()
	"Open the emacs.d/progs/my-const.el file"
	(interactive)
	(find-file (concat user-emacs-directory "init.el")))

(defun my/open/scratch ()
	"Open the scratch buffer"
	(interactive)
	(switch-to-buffer "*scratch*"))

(defun my/run/bloated-hook ()
	"Run the development environment"
	(interactive)
	(mapc (lambda (m)
					(require m)) my/bloated-hook))

(defun my/show-all ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-show-all))
	(when (bound-and-true-p hs-minor-mode)
		(hs-show-all)))

(defun my/hide-all ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-hide-body))
	(when (bound-and-true-p hs-minor-mode)
		(hs-hide-all)))

(defun my/hide-entry ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-hide-entry))
	(when (bound-and-true-p hs-minor-mode)
		(hs-hide-block)))

(defun my/show-entry ()
	"T."
	(interactive)
	(when (bound-and-true-p outline-minor-mode)
		(outline-show-entry))
	(when (bound-and-true-p hs-minor-mode)
		(hs-show-block)))

(provide 'my-defun)	
