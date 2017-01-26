(deftest test-environment ()
  (let* ((inner (extend-environment '(a) '(0) *the-empty-environment*))
	 (outer (extend-environment '(a b) '(1 2) inner)))
    ;;check lookup-variable-value
    (check 
     (= (lookup-variable-value 'a inner) 0)
     (= (lookup-variable-value 'a outer) 1)
     (= (lookup-variable-value 'b outer) 2))
   ;;check nset-variable-value
    (nset-variable-value 'a 3 outer)
    (check 
      (= (lookup-variable-value 'a outer) 3)
      (= (lookup-variable-value 'a inner) 0))
   ;;check ndefine-variable
    (ndefine-variable 'c 4 outer)
    (check
      (null (lookup-variable-value 'c inner))
      (= (lookup-variable-value 'c outer)))))

;;register test
(put-test-func 'test-environment #'test-environment)
