;;if
(defun if-predicate (exp) (cadr exp))
(defun if-consequent (exp) (caddr exp))
(defun if-alternative (exp)
  (if (not (null (cdddr exp)))
      (cadddr exp)
      'false))
(defun make-if (predicate consequent alternative)
  (list 'if predicate consequent alternative))

(defun analyze-if (exp)
  (let ((pproc (analyze (if-predicate exp)))
	(cproc (analyze (if-consequent exp)))
	(aproc (analyze (if-alternative exp))))
    #'(lambda (env)
	(if (true-p (funcall pproc env))
	    (funcall cproc env)
	    (funcall aproc env)))))
(put-analyze-func 'if #'analyze-if)