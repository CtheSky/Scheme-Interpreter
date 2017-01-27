(deftest code-example-gcd ()
  (let ((env (extend-environment '() '() *env*)))
    ;;define gcd in interpreter
    (meval 
     '(define (gcd a b)
       (if (= b 0)
	   a
	   (gcd b (remainder a b)))) 
     env)
    (dotimes (i 20)
      (dotimes (j i)
	(check (= (gcd j i) (meval `(gcd ,j ,i) env)))))))

;;register test
(put-test-func 'code-example-gcd #'code-example-gcd)
