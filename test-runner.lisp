;;;test func table
(defparameter *test-func-table* (make-hash-table))
(defun put-test-func (type proc) (setf (gethash type *test-func-table*) proc))
(defun get-test-func (type) 
    (multiple-value-bind (func present) (gethash type *test-func-table*)  
      (declare (ignore present))
      func))

;;;load interpreter and test framework
(load "environment.lisp")
(load "eval-apply.lisp")
(load "analyze-func-table.lisp")
(dolist (path (directory ".//special-form//*.lisp"))
	   (load path)) 
(load ".//test//framework.lisp")

;;;load all tests
(dolist (path (directory ".//test//*.lisp"))
	   (load path)) 


;;;test interface loop
(defun test-interface-loop ()
  (format t "~%~%~a~%" ";;;Enter test commond: (? for help)")
  (let ((input (read-line))
	(want-to-quit nil))
    (cond ((equalp input "quit")
	   (setf want-to-quit t))
	  ((equalp input "load")
	   (dolist (path (directory ".//test//*.lisp"))
	     (load path))
	   (format t "~%~a~%" "all tests loaded"))
	  ((equalp input "list")
	   (format t "~%")
	   (maphash #'(lambda (k v) (format t "~a~%" k)) *test-func-table*)
	   (format t "~%"))
	  ((equalp input "test all")
	   (maphash #'(lambda (k v) (funcall v)) *test-func-table*))
	  ((get-test-func (intern (string-upcase input)))
	   (funcall (get-test-func (intern (string-upcase input)))))
	  (t
	   (format t 
		   "~%Commands:~%~a~%~a~%~a~%~a~%~a~%"
		   "quit            => end test runner"
		   "load            => reload all tests"
		   "list            => list all loaded tests"
		   "<test-name>     => execute <test-name>"
		   "test all        => run all tests")))
    (if (not want-to-quit)
	(test-interface-loop))))

;;trigger loop
(test-interface-loop)
