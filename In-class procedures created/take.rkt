(define take
  (lambda (how-many s-list)
    (if (or (null? s-list) (zero? how-many))
        '()
        (cons (car s-list) 
              (take (- how-many 1) (cdr s-list))))))