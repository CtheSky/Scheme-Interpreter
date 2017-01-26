(load "environment.lisp")

;;;load analyze funcs of special forms
(load "analyze-func-table.lisp")
(dolist (path (directory ".//special-form//*.lisp"))
	   (load path)) 

(load "eval-apply.lisp")
(load "repl.lisp")


;;driver REPL
(read-eval-print-loop)
