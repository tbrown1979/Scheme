;;
;; FILE:     homework02.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     01/29/13
;; COMMENT:  Creating 5 basic procedures.
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;

(define candy-temperature 
        (lambda (temp ft) 
          (- temp (/ ft 500.0))))

(define grade 
        (lambda (hw quiz final)
          (/ (+ (* hw 35.0) (* quiz 35.0) (* final 30.0)) 100 )))

(define ladder-height
        (lambda (c a)
          (sqrt (- (expt c 2) (expt a 2) ) ) ) )
          
(define in-range?
        (lambda (a b)
          (<= (abs(- a b)) *epsilon*)))

(define string-binding?
        (lambda ( binding )
          (cond ((not (list? binding)) #f)
                ((not(equal? 2 (length binding))) #f)
                (else (and (symbol? (car binding)) (string? (car (cdr binding))))))))
