;;let
(defun let-body (exp) (cddr exp))
(defun let-vars (exp) (map 'list #'car (cadr exp)))
(defun let-vals (exp) (map 'list #'cadr (cadr exp)))

(defun analyze-let (exp)
  (let ((vars (let-vars exp))
	(vals (let-vals exp))
	(body (let-body exp)))
    (analyze `(,(make-lambda vars body) ,@vals))))
(put-analyze-func 'let #'analyze-let)
