(laod "boom-language.rkt")

(define boom/eval
  (lambda (exp)
    (boom/eval-exp (boom/preprocess exp) boom/primitives)))