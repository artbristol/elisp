					; test stuffs


(defun rejig-schedule (weeks) "spreads the TODO SCHEDULED:s evenly" (interactive "p")
       (save-excursion
	 (save-restriction
	   ;; assume we're on a scheduled TODO - TODO:check
	   ;; go up a level
	   
	   (if (not (forward-same-level-or-false)) (error "Didn't manage to go forward!"))
	   (if (not (org-up-heading-safe)) (error "Couldn't go up a level"))
	   (org-narrow-to-subtree)
	   (org-next-visible-heading 1) ;; this will go DOWN a level
	   (message "got 0; point %s" (point))
	   (let ((headlines ())) 
			       (while (progn 
					(let ((current-headline (org-element-headline-parser (point-max))))
					  (message "current header: %s" current-headline)
					  (push current-headline headlines)
					  )
					(forward-same-level-or-false))   )	
			       (dolist (headline headlines) (message "I'm in headline %s" headline )
				       (goto-char (plist-get (car (cdr headline)) ':begin))	
				       (org-schedule 1 "+1w")
				       )
			       (message "I did it: headlines: [%d]" (length headlines) )
			       )
	   )
	 )
       )

(defun forward-same-level-or-false () "moves forward by a heading or returns false"
       (interactive)
       (let ((lastpoint (point))  )
	 (org-forward-heading-same-level 1)
	 (if  (> (point) lastpoint) t nil )
       ))

	     

