(define and->if
  (lambda (and-exp)
    (cond 
      ((= (length and-exp) 2) (cadr and-exp))
      ((= (length and-exp) 3) (list 'if
                                    (cadr and-exp)
                                    (caddr and-exp)
                                    #f))
      (else (list 'if
                  (cadr and-exp)
                  (and->if (cons 'and
                                 (cddr and-exp)))
                  #f)))))