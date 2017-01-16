;;sequence
(defun analyze-sequence (exps)
  (defun make-proc-sequence (proc1 proc2)
    (lambda (env) (funcall proc1 env) (funcall proc2 env)))
  (let ((procs (map 'list #'analyze exps))
	(sequence nil))
    (if procs
	(dolist (proc procs)
	  (if sequence
	      (setf sequence (make-proc-sequence sequence proc))
	      (setf sequence proc)))
	(error "Empty sequence -- ANALYZE"))
    sequence))
