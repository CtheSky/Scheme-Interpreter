;;analyze func table
(defparameter *analyze-func-table* (make-hash-table))
(defun put-analyze-func (type proc) (setf (gethash type *analyze-func-table*) proc))
(defun get-analyze-func (type) 
    (multiple-value-bind (func present) (gethash type *analyze-func-table*)  
      (declare (ignore present))
      func))
