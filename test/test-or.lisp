(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-or ()
  (let ((env (extend-environment '() '() *env*)))
    ;;check no exp
    (check (equal nil (meval '(or) env)))
    ;;check single exp
    (check (equal t (meval '(or true) env)))
    (check (equal nil (meval '(or false) env)))
    ;;check combination
    (check (equal t (meval '(or true true) env)))
    (check (equal t (meval '(or true false) env)))
    (check (equal nil (meval '(or false false) env)))
    ;;check short circuit
    (check (equal t (meval '(or (begin (define a 1) false) true (define b 0)) env)))
    (check (= 1 (meval 'a env)))
    (check (null (meval 'b env)))))

;; trigger test
(test-or)
