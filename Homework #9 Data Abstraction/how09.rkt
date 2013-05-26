(define **xx** '**xx**)
(define record
  (lambda field-names
    (list->vector (map (lambda (n)
                         (vector n **xx**))
                       field-names))))

(define find-pos-record
  (lambda (record field pos)
    (cond ((>= pos (vector-length record)) -1)
          ((eq? (vector-ref (vector-ref record pos) 0) field) pos)
          (else (find-pos-record record field (+ 1 pos))))))

(define record-put
  (lambda (record field value)
      (vector-set! record (find-pos-record record field 0) (vector field value))
      record))

(define record-get
  (lambda (record field)
    (vector-ref (vector-ref record (find-pos-record record field 0)) 1)))
    

;                  (if (>= pos (vector-length fields))
;                      -1
;                      (if (eq? (vector-ref fields pos) field)
;                          pos
;                          (find-pos (+ 1 pos))))))))
      
(define run-length-encode
  (lambda (lst)
    (letrec ((encode-helper
              (lambda (lst prev-val amt-repeat)
                (if (null? lst)
                    '()
                    (if (and (eq? (car lst) prev-val) (= amt-repeat 2))
                        (cons (car lst) (encode-helper (cdr lst) (car lst) (+ 1 amt-repeat)))
                        (if (eq? (car lst) prev-val)
                            (encode-helper (car lst) (encode-helper (cdr lst) (car lst) (+ 1 amt-repeat)))
                            amt-repeat)))))))))

(define test
  (lambda (blurp)
    1))