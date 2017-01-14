;;;; Environment is passed through eval and it does following things:
;;;;   1. maintain the value of variables
;;;;   2. support nested lexical scope
;;;; 
;;;; Public Interface:
;;;;   1. lookup-variable-value (var env)
;;;;      returns value bound to <var> in the <env>, or signals an error if it is unbound
;;;;   2. extend-environment (vars vals base-env)
;;;;      returns a new environment bounding vars to values with base-env as enclosing environment
;;;;   3. define-variable! (var val env)
;;;;      adds var bound to value in first frame
;;;;   4. set-variable-value! (var val env)
;;;;      bound <var> in the <env> to <val>, or signals an error if the <var> is unbound
;;;;
;;;; Implemetation : A list of Hashables, each represents a frame


;;; Helper functions and global variables

(defparameter *the-empty-environment* nil)
(defun enclosing-environment (env) (cdr env))
(defun first-frame (env) (car env))
(defun make-frame (vars vals)
  (let ((frame (make-hash-table)))
    (dotimes (i (length vars))
      (let ((var (nth i vars))
	    (val (nth i vals)))
	(setf (gethash var frame) val)))
    frame))


;;; Public Interface

(defun extend-environment (vars vals base-env)
  ;;returns a new environment bounding vars to values with base-env as enclosing environment
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
	  (error "Too many arguments supplied" vars vals)
	  (error "Too few arguments supplied" vars vals))))

(defun lookup-variable-value (var env)
  ;;returns value bound to <var> in the <env>, or signals an error if it is unbound
  (dolist (frame env)
    (let ((val (gethash var frame)))
      (if val (return val)))))

(defun ndefine-variable (var val env)
  ;;adds var bound to value in first frame
  (let ((frame (first-frame env)))
    (setf (gethash var frame) val)))

(defun nset-variable-value (var val env)
  ;;bound <var> in the <env> to <val>, or signals an error if the <var> is unbound
  (dolist (frame env)
    (multiple-value-bind (old-val present) (gethash var frame)
      (when present
	(setf (gethash var frame) val)
	(return)))))
