(load "boom-language.rkt")


(define boom/eval-exp
  (lambda (exp env)
    (cond ((boom/number-exp? (boom/number-val-of exp)) exp)
          ((boom/varref-exp? exp) (look-up (boom/varref-val-of exp) env))
          ((boom/unary? exp) ((return-unary-proc (boom/unary-op-value-of exp))
                              (boom/eval-exp (boom/unary-arg-value-of exp) env)))
          ((boom/equation? exp) (boom/apply-op (boom/binary-op-value-of exp)
                                               (boom/eval-exp (boom/equation-first-value exp) env)
                                               (boom/eval-exp (boom/equation-second-value exp) env)))
                                               
           
          ((with/do-exp? exp) (boom/eval-exp (with/do->formula exp)
                                             (bind (with/do->var exp) 
                                                   (with/do->val exp) 
                                                   env)) )
    
          (else (error-report "boom/eval-exp: Invalid equation") ))))
