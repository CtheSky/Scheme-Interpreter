(deftest code-example-fib ()
  (let ((env (extend-environment '() '() *env*)))
    ;;fib used to check output 
    (defun fib (x)
      (defun iter (a b n)
	(if (= n 0)
	    a
	    (iter b (+ a b) (- n 1))))
      (iter 0 1 x))
    ;;define fib in interpreter
    (meval '(define (fib x)
	     (define (iter a b n)
	      (if (= 0 n)
		  a
		  (iter b (+ a b) (- n 1))))
	     (iter 0 1 x))
	   env)
    (dotimes (i 20)
      (check (= (fib i) (meval `(fib ,i) env))))))

;;register test
(put-test-func 'code-example-fib #'code-example-fib)

