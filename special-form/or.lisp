;;or
(defun analyze-or (exp)
  (let* ((or-exps (cdr exp))
	 (procs (map 'list #'analyze or-exps)))
    (defun or-iter (procs env)
      (if (null procs)
	  nil
	  (let* ((first-proc (car procs))
		 (rest (cdr procs))
		 (result (funcall first-proc env)))
	    (if (true-p result)
		t
		(or-iter rest env)))))
    #'(lambda (env)
	(or-iter procs env))))
(put-analyze-func 'or #'analyze-or)
