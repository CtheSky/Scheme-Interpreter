(deftest test-lambda ()
  (let* ((env (extend-environment '(a b) '(1 2) *env*)))
    (check (= (meval '((lambda (x) (+ x 1)) 1) env) 2))))

;;register test
(put-test-func 'test-lambda #'test-lambda)
