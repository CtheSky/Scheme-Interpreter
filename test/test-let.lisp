(deftest test-let ()
  (let ((env (extend-environment '(a b c) '(0 0 0) *env*)))
    (meval 
     '(let ((a 3) (b 4))
       (set! c (+ a b)))
     env)
    (check (= (meval 'c env) 7))))

;;register test
(put-test-func 'test-let #'test-let)
