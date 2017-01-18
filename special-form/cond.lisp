;;cond
(defun cond-clauses (exp) (cdr exp))
(defun cond-predicate (clause) (car clause))
(defun cond-actions (clause) (cdr clause))
(defun cond-else-clause-p (clause)
  (equal (cond-predicate clause) 'else))
(defun cond->if (exp)
  (expand-clause (cond-clauses exp)))
(defun expand-clause (clauses)
  (if (null clauses)
      'false ;if no else clause, set false as default return value
      (let ((first (car clauses))
	    (rest (cdr clauses)))
	(if (cond-else-clause-p first)
	    (if (null rest)
		(sequence->exp (cond-actions first))
		(error "ELSE clause isn't last -- COND->IF" clauses))
	    (make-if (cond-predicate first)
		     (sequence->exp (cond-actions first))
		     (expand-clause rest))))))

(defun analyze-cond (exp)
  (analyze (cond->if exp)))
(put-analyze-func 'cond #'analyze-cond)




