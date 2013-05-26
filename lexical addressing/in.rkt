(define in?                                                              ;
  (lambda (to-compare lst)                                               ;
    (if (null? lst)                                                      ;
        #f                                                               ;
        (or (in?-symexp to-compare (car lst))                            ;
             (in? to-compare (cdr lst))))))                              ;
                                                                         ;
(define in?-symexp                                                       ;
  (lambda (to-compare symexp)                                            ;
    (if (symbol? symexp)                                                 ;
        (eq? symexp to-compare)                                          ;
        (in? to-compare symexp))))    