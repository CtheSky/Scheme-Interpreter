;;definetion
(defun definition-variable (exp)
  (if (symbolp (cadr exp))
      (cadr exp)
      (caadr exp)))
(defun definition-value (exp)
  (if (symbolp (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
		   (cddr exp))))

(defun analyze-definition (exp)
  (let ((var (definition-variable exp))
	(vproc (analyze (definition-value exp))))
    #'(lambda (env)
	(format t "def-var ~a ~%" var)  
	(format t "def-vproc ~a ~%" (funcall vproc env))
	(ndefine-variable var (funcall vproc env) env)
	'ok)))
(put-analyze-func 'define #'analyze-definition)