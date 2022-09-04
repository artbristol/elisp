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
	   (let ((headlines ())) 
	     (while (progn
		      (let ((current-headline (org-element-headline-parser (point-max))))
			(push current-headline headlines)
			)
		      (forward-same-level-or-false)))
	     (let ((curr-week (* weeks  (length headlines))))
	       (dolist (headline headlines)

		 (goto-char (plist-get (car (cdr headline)) ':begin))
		 		 (message "I'm in headline %s; going to char %d" headline (point) )
		       ;; no need to unschedule, org-schedule will wipe
				 (org-schedule 1 (format "+%dw" curr-week))
				 ;; TODO add ++%dw for weeks recurrence
		       (setq curr-week (- curr-week weeks))
		       ))
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

	     

