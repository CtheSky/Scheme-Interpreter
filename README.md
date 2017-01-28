# Scheme-Interpreter
A Common Lisp implementation of Scheme Interpreter build during learning SICP.
  
It supports a basic subset of scheme syntax with no macro system:  
  1. Supported primitive operators could be found in 
  [eval-apply.lisp](https://github.com/CtheSky/Scheme-Interpreter/blob/common-lisp/eval-apply.lisp).
  2. Supported special syntax forms (such as `if`,`begin`, `and`.etc) could be found in 
  [special-form](https://github.com/CtheSky/Scheme-Interpreter/tree/common-lisp/special-form) folder.
  
# Usage
```lisp
;; it will automaticly start a scheme REPL
(load "start-repl.lisp")

;; if you want to explicitly call eval
;; you could comment last line in "start-repl.lisp":
;;    "(read-eval-print-loop)" -> ";;(read-eval-print-loop)" 
;; then call meval function with *env* which is the initial global environment
(meval '(define (double x) (* x 2)) *env*)
```

# Test
All tests are under [test](https://github.com/CtheSky/Scheme-Interpreter/tree/common-lisp/test) folder,
written in a tiny test framework from [Practical Common Lisp](http://www.gigamonkeys.com/book/practical-building-a-unit-test-framework.html).
  
And I add an interface to manipulate all test cases:
```lisp
(load "test-runner.lisp")
;; it will start an read-test-print loop
;; and looks like following:
```
```
Enter test commond: (? for help)
?

Commands:
quit            => end test runner
load            => reload all tests
list            => list all loaded tests
<test-name>     => execute <test-name>
test all        => run all tests


Enter test commond: (? for help)
test-if
pass ... (TEST-IF): (= (MEVAL '(IF TRUE 1 0) ENV) 1)
pass ... (TEST-IF): (= (MEVAL '(IF FALSE 1 0) ENV) 0)
pass ... (TEST-IF): (= (MEVAL 'A *ENV*) 1)

```
