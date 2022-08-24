(use-package eww
	:init
	(setq-local endless/display-images t)

	(defun endless/toggle-image-display ()
		"Toggle images display on current buffer."
		(interactive)
		(setq endless/display-images
					(null endless/display-images))
		(endless/backup-display-property endless/display-images))

	(defun endless/backup-display-property (invert &optional object)
		"Move the 'display property at POS to 'display-backup.
Only applies if display property is an image.
If INVERT is non-nil, move from 'display-backup to 'display
instead.
Optional OBJECT specifies the string or buffer. Nil means current
buffer."
		(let* ((inhibit-read-only t)
					 (from (if invert 'display-backup 'display))
					 (to (if invert 'display 'display-backup))
					 (pos (point-min))
					 left prop)
			(while (and pos (/= pos (point-max)))
				(if (get-text-property pos from object)
						(setq left pos)
					(setq left (next-single-property-change pos from object)))
				(if (or (null left) (= left (point-max)))
						(setq pos nil)
					(setq prop (get-text-property left from object))
					(setq pos (or (next-single-property-change left from object)
												(point-max)))
					(when (eq (car prop) 'image)
						(add-text-properties left pos (list from nil to prop) object))))))


	(defun my/eww-toggle-images ()
		"Toggle whether images are loaded and reload the current page fro cache."
		(interactive)
		(setq-local shr-inhibit-images (not shr-inhibit-images))
		(eww-reload t)
		(message "Images are now %s"
						 (if shr-inhibit-images "off" "on")))

	(define-key eww-mode-map (kbd "I") #'my/eww-toggle-images)
	(define-key eww-link-keymap (kbd "I") #'my/eww-toggle-images)

	;; minimal rendering by default
	(setq-default shr-inhibit-images t)   ; toggle with `I`
	(setq-default shr-use-fonts nil)      ; toggle with `F`

	(defun with-faicon (icon str &rest height v-adjust)
    (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))
																				;filecon
	(defun with-fileicon (icon str &rest height v-adjust)
    (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))
	(setq eww-title (with-faicon "globe" "Eww Browser Command"))
																				;generate hydra
	(pretty-hydra-define eww-browser (:title eww-title :quit-key "q" :color pink )
		("A"
		 (
			("G" eww "Eww Open Browser")
			("g" eww-reload "Eww Reload")
			("6" eww-open-in-new-buffer "Open in new buffer")
			("l" eww-back-url "Back Url")
			("r" eww-forward-url "Forward Url")
			("N" eww-next-url "Next Url")
			("P" eww-previous-url "Previous Url")
			("u" eww-up-url "Up Url")
			("&" eww-browse-with-external-browser "Open in External Browser")
			("d" eww-download "Download")
			("w" eww-copy-page-url "Copy Url Page")
			);end theme
		 "B"
		 (
			("T" endless/toggle-image-display "Toggle Image Display")    
			(">" shr-next-link "Shr Next Link")
			("<" shr-previous-link "Shr Previous Link")
			("n" scroll-down-command "Scroll Down")
			("C" url-cookie-list "Url Cookie List")
			("v" eww-view-source "View Source")
			("R" eww-readable "Make Readable")
			("H" eww-list-histories "List History")
			("E" eww-set-character-encoding "Character Encoding")
			("s" eww-switch-to-buffer "Switch to Buffer")
			("S" eww-list-buffers "List Buffers")
			);end highlighting

		 "C"
		 (

			("1" hackernews "Hackernews")
			("2" hackernews-button-browse-internal "Hackernews browse link eww (t)")
			("3" hackernews-new-stories "Hackernews New Stories")
			("5" hackernews-switch-feed "Hackernews Switch Feed")
			("6" hackernews-best-stories "Hackernews Best Stories")
			("F" eww-toggle-fonts "Toggle Fonts")
			("D" eww-toggle-paragraph-direction "Toggle Paragraph Direction")
			("c" eww-toggle-colors "Toggle Colors")
			("b" eww-add-bookmark "Add Bookmark")
			("B" eww-list-bookmarks "List Bookmarks")
			("=" eww-next-bookmark "Next Bookmark")
			("-" eww-previous-bookmark "Previous Bookmark")
			("h" hydra-helm/body "Return To Helm" :color blue )
			("<SPC>" nil "Quit" :color pink)
			);end other
		 );end hydra body
		);end pretty-hydra-eww
	);end with eveal after load eww

(provide 'my-eww)
