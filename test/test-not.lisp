(deftest test-not ()
  (let ((env (extend-environment '() '() *env*)))
    (check (equal t (meval '(not false) env)))
    (check (equal nil (meval '(not true) env)))))

;;register test
(put-test-func 'test-not #'test-not)
