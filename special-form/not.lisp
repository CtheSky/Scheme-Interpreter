;;not
(defun analyze-not (exp)
    (cond  ((null (cdr exp)) 
	    (error "No expression form wrapped in not -- ANALYZE-NOT" exp))
	   ((not (null (cddr exp)))
	    (error "More than one form wrapped in not -- ANALYZE-NOT" exp))
	   (t
	    (let ((proc (analyze (cadr exp))))
	      #'(lambda (env)
		  (not (funcall proc env)))))))
(put-analyze-func 'not #'analyze-not)
