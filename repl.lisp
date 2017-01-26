;;imtate REPL
(defvar +input-prompt+ ";;; M-Eval input:")
(defvar +output-prompt+ ";;; M-Eval value:")

(defun prompt-for-input (str)
  (format t "~%~%~a~%" str))
(defun announce-for-output (str)
  (format t "~%~a~%" str))

(defun user-print (object)
  (if (compound-procedure-p object)
      (format t 
	      "~a ~a ~a ~a"
	      'compound-procedure
	      (procedure-parameters object)
	      (procedure-body object)
	      '<procedure-env>)
      (format t "~a" object)))

(defun read-eval-print-loop ()
  (prompt-for-input +input-prompt+)
  (let ((input (read)))
    (let ((output (meval input *env*)))
      (announce-for-output +output-prompt+)
      (user-print output)))
  (read-eval-print-loop))
    
