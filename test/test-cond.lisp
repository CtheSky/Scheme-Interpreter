(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-cond ()
  (let ((env *env*))
    ;;check single clause
    (check (= (meval '(cond (true 1)) env) 1))
    ;;check regular clause
    (check (= (meval '(cond (true 1) (else 0)) env) 1))
    ;;check else clause
    (check (= (meval '(cond (false 1) (else 0)) env) 0))
    ;;check default value when none of clauses are executed
    (check (equal (meval '(cond (false 1) (false 0)) env) nil))))

;; trigger test
(test-cond)
