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
	((application-p exp)
	 (analyze-application exp))
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

;;;procedure
(defun make-procedure (parameters body env)
    (list 'procedure 
	  parameters 
	  body 
	  (nstore-environment env)))
(defun compound-procedure-p (exp)
    (and (consp exp) (equal (car exp) 'procedure)))
(defun procedure-parameters (exp) (cadr exp))
(defun procedure-body (exp) (caddr exp))
(defun procedure-environment (exp) (get-environment (cadddr exp)))

;;;primitive-procdures
(defun primitive-procedure-p (exp)
  (and (consp exp) (equal (car exp) 'primitive)))
(defun primitive-implementation (proc) (cadr proc))
(defun apply-primitive-procedure (proc args)
  (apply (primitive-implementation proc) args))
(defun primitive-procedure-names () 
  (map 'list #'car primitive-procedures))
(defun primitive-procedure-objects () 
  (map 'list
       #'(lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))
(defparameter primitive-procedures
  (list (list 'car #'car)
	(list 'cdr #'cdr)
	(list 'cons #'cons)
	(list 'equal #'equal)
	(list 'null? #'null)
	(list '= #'=)
	(list '> #'>)
	(list '>= #'>=)
	(list '< #'<)
	(list '<= #'<=)
	(list '+ #'+)
	(list '- #'-)
	(list '* #'*)
	(list '/ #'/)
	))

;; true and false
(defun true-p (x) (not (equal x nil)))
(defun false-p (x) (equal x nil))

;;setup initial envrionment
(defparameter *env*
  (extend-environment 
   (primitive-procedure-names)  
   (primitive-procedure-objects)
   *the-empty-environment*))
(ndefine-variable 'true t *env*)
(ndefine-variable 'false nil *env*)


;;application
(defun application-p (exp) (consp exp))
(defun operator (exp) (car exp))
(defun operands (exp) (cdr exp))

;;;mapply
(defun analyze-application (exp)
  (let ((fproc (analyze (operator exp)))
	(aprocs (map 'list #'analyze (operands exp))))
    (lambda (env)
      (execute-application
       (funcall fproc env)
       (map 'list 
	    #'(lambda (aproc) (funcall aproc env))
	    aprocs)))))

(defun execute-application (proc args)
  (cond ((primitive-procedure-p proc)
	 (apply-primitive-procedure proc args))
	((compound-procedure-p proc)
	 (funcall 
	  (procedure-body proc)
	  (extend-environment
	   (procedure-parameters proc)
	   args
	   (procedure-environment proc))))
	(t
	 (error "Unknown procedure type: EXECUTE-APPLICATION" proc))))


	  
