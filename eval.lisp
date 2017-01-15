(load "environment.lisp")

;;;load analyze funcs of special forms
(load "analyze-func-table.lisp")
(dolist (path (directory ".//special-form//*.lisp"))
	   (load path)) 

;;;meval
;;;  receives an expression and environment, eval the expr in given env
(defun meval (exp env)
  (funcall (analyze exp) env))

;;; analyze
;;;  receives an expression, return corresponding lambda function 
(defun analyze (exp)
  (cond ((self-evaluating-p exp) (analyze-self-evaluating exp))
	((variable-p exp) (analyze-variable exp))
	((get-analyze-func (car exp))
	 (funcall (get-analyze-func (car exp)) exp))
	(t
	 (error "Unknown expression type -- ANALYZE" exp))))

;;;self-evaluate
(defun self-evaluating-p (exp)
  (cond ((numberp exp) t)
	((stringp exp) t)
	(t nil)))
(defun analyze-self-evaluating (exp)
  (lambda (env) (declare (ignore env)) exp))

;;;variable
(defun variable-p (exp) (symbolp exp))
(defun analyze-variable (exp)
  (lambda (env) (lookup-variable-value exp env)))
