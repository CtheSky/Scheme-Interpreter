;;;; Environment:
;;;;  It is passed through eval and it does following things:
;;;;   1. maintain the value of variables
;;;;   2. support nested lexical scope
;;;;  Public Interface:
;;;;   1. lookup-variable-value (var env)
;;;;      returns value bound to <var> in the <env>, or signals an error if it is unbound
;;;;   2. extend-environment (vars vals base-env)
;;;;      returns a new environment bounding vars to values with base-env as enclosing environment
;;;;   3. ndefine-variable! (var val env)
;;;;      adds var bound to value in first frame
;;;;   4. nset-variable-value! (var val env)
;;;;      bound <var> in the <env> to <val>, or signals an error if the <var> is unbound
;;;;  Implemetation : A list of Hashables, each represents a frame
;;;;
;;;; An Environment table:
;;;;  Why this?
;;;;   When implementing function, it should be capable of telling which environment it has been defined
;;;;   to ensure the corretness of scope rule. But since hashtable couldn't contains itself, so I need 
;;;;   another way: function holds an symbol which maps to the environment, and all this mapping information
;;;;   is stored in a table.
;;;;  Public Interface:
;;;;   5. nstore-environment (env)
;;;;      returns a unique symbol which maps to <env> in the table
;;;;   6. get-environment (symbol)
;;;;      returns corresponding environment

;;; Helper functions and global variables
(defparameter *environment-table* (make-hash-table))
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

(defun nstore-environment (env)
  ;;returns a unique symbol which maps to <env> in the table
  (let ((symbol (gensym)))
    (setf (gethash symbol *environment-table*) env)
    symbol))

(defun get-environment (symbol)
  ;;returns corresponding environment
  (gethash symbol *environment-table*))
