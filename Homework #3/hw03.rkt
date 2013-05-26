;;
;; FILE:     homework03.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     02/04/13
;; COMMENT:  Practice at creating procedures that return procedures, and also
;;           working with variable arity procedures. 
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;

(define softmax
  (lambda ( x y )
    (log (+ (exp x) (exp y) ))))

(define sum-of-apps
  (lambda ( procedure x y )
    (+ (procedure x) (procedure y))))

(define candy-temperature-of 
  (lambda ( temp )
    (lambda ( elevation )
      (- temp (/ elevation 500.0)))))

(define in-range-of?
  (lambda ( epsilon )
    (lambda ( limit-one limit-two )
      (<= (abs(- limit-one limit-two)) epsilon))))

(define softmax-var
  (lambda numbers-given
    (log (apply + (map exp numbers-given)))))

(define sum-of
  (lambda (given-app)
    (lambda values
      (apply + (map given-app values)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define sequence
  (lambda (start finish)
    (if (> start finish)
        '()
        (cons start (sequence (+ start 1) finish)))))

(define square
  (lambda ( x )
    (expt x 2)))

(define cube
  (lambda ( x )
    (expt x 3)))

(define curried-modulo
  (lambda (divisor)
    (lambda (dividend)
      (modulo dividend divisor))))
      

