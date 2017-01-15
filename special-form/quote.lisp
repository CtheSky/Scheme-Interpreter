;;quote
(defun text-of-quotation (exp) (cadr exp))
(defun make-quote (exp) (list 'quote exp))

(defun analyze-quoted (exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) (declare (ignore env)) qval)))
(put-analyze-func 'quote #'analyze-quoted)
