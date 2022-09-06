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
	   (let ((headlines ()) (target-level -1) (headline-count 0))
	     (setq target-level (plist-get (car (cdr (org-element-headline-parser (point-max)))) ':level))
	     (message "target-level: %d" target-level)
	     (org-map-entries
	      (lambda () (setq headline-count (+ headline-count 1)))
	      (format "+LEVEL=%d" target-level)
	      )
	     (let ((curr-week 0))
    	       (org-map-entries
		(lambda ()
	    	  (org-schedule 1 (format "+%dw" curr-week))
	    	  (setq curr-week (+ curr-week weeks))
		  )
		(format "+LEVEL=%d" target-level))
	       )
	     (org-map-entries
	      (lambda ()
		(let* (
		       (current-headline (org-element-headline-parser (point-max)))
		       (current-scheduled (plist-get (car (cdr current-headline)) ':scheduled))
		       )
					; TODO it would be better to use a proper org- function to do the below
		  (goto-char (- (plist-get (car (cdr current-scheduled)) ':end) 1))
		  (insert " " (format "++%dw" (* weeks headline-count)))
                  ))
	      (format "+LEVEL=%d" target-level))
	     (message "I did it: headlines: [%d]" headline-count )
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



