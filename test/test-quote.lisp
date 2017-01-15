(load "eval.lisp")
(load ".//test//framework.lisp")

(deftest test-quote ()
  (let* ((env (extend-environment '(a b) '(1 2) *the-empty-environment*)))
    (check 
     (equal (meval ''a env) 'a)
     (equal (meval ''b env) 'b)
     (equal (meval 'a env) 1)
     (equal (meval 'b env) 2))))

;; trigger test
(test-quote)
