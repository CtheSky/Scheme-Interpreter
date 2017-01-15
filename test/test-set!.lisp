(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-set! ()
  (let* ((env (extend-environment '(a b) '(1 2) *the-empty-environment*)))
    (check 
     (equal (meval 'a env) 1)
     (equal (meval 'b env) 2))
    (meval '(set! a 0) env)
    (meval '(set! b 0) env)
    (check
      (equal (meval 'a env) 0)
      (equal (meval 'b env) 0))))

;; trigger test
(test-set!)
