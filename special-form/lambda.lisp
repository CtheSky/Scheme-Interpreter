;;lambda
(defun lambda-parameters (exp) (cadr exp))
(defun lambda-body (exp) (cddr exp))
(defun make-lambda (parameters body)
  (cons 'lambda (cons parameters body)))

(defun analyze-lambda (exp)
  (let ((vars (lambda-parameters exp))
	(bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))
(put-analyze-func 'lambda #'analyze-lambda)
