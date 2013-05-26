;;
;; FILE:     homework05.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     02/20/13
;; COMMENT:  Practice at creating recursive procedures using Mutual Recursion
;;           and Accumulator 'variables'
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;
(define all-positive? 
  (lambda (n-list)
    (if (null? n-list)
        #t
        (and (all-positive-numexp (car n-list))
             (all-positive? (cdr n-list))))))

(define all-positive-numexp
  (lambda (numexp)
    (if (number? numexp)
        (positive? numexp)
        (all-positive? numexp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define reject
  (lambda (test n-list)
    (if (null? n-list)
        '()
        (append (reject-numexp test (car n-list))
                (reject test (cdr n-list))))))

(define reject-numexp
  (lambda (test numexp)
    (if (number? numexp)
        (if (not (test numexp)) 
            (list numexp)
            '())
        (reject test numexp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define inject
  (lambda (initial-value f lon)
    (inject-accumulator initial-value f lon 0)))


(define inject-accumulator
  (lambda (initial-value f lon total)
    (if (null? lon)
        initial-value
        (f (inject-numexp initial-value f (car lon) total)
           (inject-accumulator initial-value f (cdr lon) total)))))

(define inject-numexp
  (lambda (initial-value f numexp total)
    (if (number? numexp)
        (+ total numexp)
        (inject-accumulator initial-value f numexp total))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define uniq
  (lambda (slst)
    (uniq-aps slst '())))

(define uniq-aps
  (lambda (slst symbols-no-repeats)
    (if (null? slst)
        symbols-no-repeats
        (uniq-aps (cdr slst)  
                  (uniq-aps-symexp (car slst) symbols-no-repeats)))))

(define uniq-aps-symexp
  (lambda (symexp symbols-no-repeats)
    (if (symbol? symexp)
        (if (in? symexp symbols-no-repeats)
            symbols-no-repeats
            (cons symexp symbols-no-repeats))
        (uniq-aps symexp symbols-no-repeats))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define prefix->infix
  (lambda (binary-exp)
    (if (or (number? binary-exp) (symbol? binary-exp))
        binary-exp
        (list (prefix->infix (car (cdr binary-exp))) (car binary-exp) (prefix->infix (car (cdr (cdr binary-exp))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define in?
  (lambda (to-compare lst)
    (if (null? lst)
        #f
        (or (in?-symexp to-compare (car lst))
             (in? to-compare (cdr lst))))))

(define in?-symexp
  (lambda (to-compare symexp)
    (if (symbol? symexp)
        (eq? symexp to-compare)
        (in? to-compare symexp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(all-positive? '(1 -2 3 4))
(all-positive? '((1 (2 7 (10))) (-3 4)))
(all-positive? '((1 (2 7 (10))) (3 4)))

(reject even? '(1 -2 3 4))
(reject positive? '(1 -2 3 4))
(reject (lambda (n) (< n 4))
                 '((1 (2 7 (10))) (3 4)))
(reject negative? '((1 (2 7 (10))) (3 4)))
(reject positive? '((1 (2 7 (10))) (3 4)))

(inject 0 + '(25 50 -30 45 -10 -15))
(inject 955.52 + '(27.52 27.52 -50.00 37.52 -50.00))
(inject 0 max (reject (lambda (n) (> n 6))
                         '((1 (2 7 (-10))) (3 3))))

(uniq '((a b) (((b g r) (f r)) c (d e)) b))
(uniq '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
(uniq '(define map-slst
                (lambda (f slst)
                  (if (null? slst)
                      '()
                      (cons (map-sym-expr f (car slst))
                            (map-slst     f (cdr slst)))))))

(prefix->infix '(* (+ 4 5) (+ 7 6)))
(prefix->infix '(* (* (+ 3 5) (- 3 (/ 4 3))) (- 25 4)))
(prefix->infix '(* (* (+ 3 5) (- 3 (/ 4 3))) (- (* (+ 4 5) (+ 7 6)) 4)))
