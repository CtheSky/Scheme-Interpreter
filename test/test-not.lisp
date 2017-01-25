(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-not ()
  (let ((env (extend-environment '() '() *env*)))
    (check (equal t (meval '(not false) env)))
    (check (equal nil (meval '(not true) env)))))

;; trigger test
(test-not)
