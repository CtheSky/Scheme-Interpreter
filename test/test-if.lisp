(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-if ()
  (let* ((env *env*))
    ;;check true value
    (check (= (meval '(if true 1 0) env) 1))
    ;;check false value 
    (check (= (meval '(if false 1 0) env) 0))
    ;;check execute stmt
    (meval 
     '(if (< 0 1)
       (define a 1)
       (define a 0))
     *env*)
    (check (= (meval 'a *env*) 1))))

;; trigger test
(test-if)
