(load "boom-language.rkt")

(define boom/preprocess
  (lambda (exp)
    (cond ((boom/number?      exp) (boom/number->val   exp))
          ((boom/unary?       exp) (boom/pp-unary      exp))
          ((boom/binary-exp?  exp) (boom/pp-binary-exp exp))
          ((boom/varref?      exp)                     exp)
          ((boom/with-do?     exp) (boom/pp-with-do    exp))
          ((boom/assign?      exp) (boom/pp-assign     exp))
          ((boom/begin-end?   exp) (boom/pp-begin-end  exp))
          (else  (list 'boom '-- 'illegal 'expression: exp)) )))