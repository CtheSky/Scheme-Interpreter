(deftest test-and ()
  (let ((env (extend-environment '() '() *env*)))
    ;;check no exp
    (check (equal t (meval '(and) env)))
    ;;check single exp
    (check (equal t (meval '(and true) env)))
    (check (equal nil (meval '(and false) env)))
    ;;check combination
    (check (equal t (meval '(and true true) env)))
    (check (equal nil (meval '(and true false) env)))
    ;;check short circuit
    (check (equal nil (meval '(and (define a 1) false (define b 0)) env)))
    (check (= 1 (meval 'a env)))
    (check (null (meval 'b env)))))

;;register test
(put-test-func 'test-and #'test-and)
