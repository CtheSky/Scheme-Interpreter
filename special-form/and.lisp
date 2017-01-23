;;and
(defun analyze-and (exp)
  (let* ((and-exps (cdr exp))
	 (procs (map 'list #'analyze and-exps)))
    (defun and-iter (procs env)
      (if (null procs)
	  t
	  (let* ((first-proc (car procs))
		 (rest (cdr procs))
		 (result (funcall first-proc env)))
	    (cond ((not (true-p result)) nil)
		  ((null rest) result)
		  (t (and-iter rest env))))))
    #'(lambda (env)
	(and-iter procs env))))
(put-analyze-func 'and #'analyze-and)
    
