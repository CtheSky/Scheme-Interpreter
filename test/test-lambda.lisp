(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-lambda ()
  (let* ((env (extend-environment '(a b) '(1 2) *env*)))
    (check (= (meval '((lambda (x) (+ x 1)) 1) env) 2))))

;; trigger test
(test-lambda)
