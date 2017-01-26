(deftest test-define ()
  (let* ((env (extend-environment '(a b) '(1 2) *env*)))
    ;;check define variable
    (meval '(define c 0) env)
    (check (= (meval 'c env) 0))
    ;;check define function 
    (meval '(define (inc x) (+ x 1)) env)
    (check (= (meval '(inc 1) env) 2))))

;;register test
(put-test-func 'test-define #'test-define)
