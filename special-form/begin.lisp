;;begin
;; depends on: "sequence.lisp"
(defun begin-actions (exp) (cdr exp))
(defun last-exp-p (seq) (null (cdr seq)))
(defun first-exp (seq) (car seq))
(defun rest-exps (seq) (cdr seq))
(defun make-begin (seq) (cons 'begin seq))
(defun sequence->exp (seq)
  ;; returns an expression representing given sequence, enclose with begin if needed
  (cond ((null seq) seq)
	((last-exp-p seq) (first-exp seq))
	(t (make-begin seq))))

(defun analyze-begin (exp)
  (analyze-sequence (begin-actions exp)))
(put-analyze-func 'begin #'analyze-begin)
