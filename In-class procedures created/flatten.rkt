(define flatten-with-accumulator
  (lambda (slst symbols-so-far)
    (if (null? slst)
        symbols-so-far
        (flatten-sym-expr (car slst)
                          (flatten-with-accumulator (cdr slst) symbols-so-far)))))

(define flatten-sym-expr
  (lambda (sym-expr symbols-so-far)
    (if (symbol? sym-expr)
        (cons sym-expr symbols-so-far)
        (flatten-with-accumulator sym-expr symbols-so-far))))

(define flatten 
  (lambda (slst)
    (flatten-with-accumulator slst '())))