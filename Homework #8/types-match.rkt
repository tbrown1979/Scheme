(define types-match?
  (lambda (types items)
    (cond
      ((and (null? types) (null? items)) #t)
      ((null? items) #f)
      (else (types-match?-helper types items)))))
        
(define types-match?-helper
  (lambda (types items)
    (if (and (>= 1 (length types)) (null? items))
        #t
        (and ((car types) (car items))
             (types-match?-helper (if (null? (cdr types))
                                      types
                                      (cdr types))
                                  (cdr items))))))
