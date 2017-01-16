;;begin
;; depends on: "sequence.lisp"
(defun begin-actions (exp) (cdr exp))
(defun last-exp-p (seq) (null (cdr seq)))
(defun first-exp (seq) (car seq))
(defun rest-exps (seq) (cdr seq))
(defun make-begin (seq) (cons 'begin seq))

(defun analyze-begin (exp)
  (analyze-sequence (begin-actions exp)))
(put-analyze-func 'begin #'analyze-begin)
