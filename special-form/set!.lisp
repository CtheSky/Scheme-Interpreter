;;assignment
(defun assignment-variable (exp) (cadr exp))
(defun assignment-value (exp) (caddr exp))

(defun analyze-assignment (exp)
  (let ((var (assignment-variable exp))
	(vproc (analyze (assignment-value exp))))
    (lambda (env)
      (nset-variable-value var (funcall vproc env) env)
      'ok)))
(put-analyze-func 'set! #'analyze-assignment)
