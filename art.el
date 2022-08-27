					; test stuffs


(defun rejig-schedule (weeks) "spreads the TODO SCHEDULED:s evenly" (interactive "p")
       (save-excursion
	 (save-restriction
	   ;; assume we're on a scheduled TODO - TODO:check
	   ;; go up a level
	   
	   (if (not (forward-same-level-or-false)) (error "Didn't manage to go forward!"))
	   (if (not (org-up-heading-safe)) (error "Couldn't go up a level"))
	   (org-narrow-to-subtree)
	   (org-next-visible-heading 1)
	   (message "got 0; point %s" (point))
	   (while (forward-same-level-or-false) ;; TODO:this is accidentally skipping the first
	     (message "got 1")
	     (let ((nothing  (message "got 2")) (current-headline (org-element-headline-parser (point-max))))c
	       (push-mark)      
	       (message "current header: %s" current-headline)
	       )
	     )
	   (message "I did it: weeks: [%d]" weeks )
	   )
	 )
       )

(defun forward-same-level-or-false () "moves forward by a heading or returns false"
       (interactive)
       (let ((lastpoint (point))  )
	 (org-forward-heading-same-level 1)
	 (if  (> (point) lastpoint) t nil )
       ))

	     

