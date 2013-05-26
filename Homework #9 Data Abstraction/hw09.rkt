;;
;; FILE:     homework09.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     04/07/13
;; COMMENT:  data abstraction
;;           
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;
;; -----------------------------------------------------------
;; Problem 1
;; -----------------------------------------------------------
#lang eopl
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
;; -----------------------------------------------------------
;; Problem 2
;; -----------------------------------------------------------
(define-datatype binary-tree binary-tree?
  (leaf-node     (datum number?))
  (interior-node (key   symbol?) 
                 (left  binary-tree?)
                 (right binary-tree?)))

(define bintree-member? 
  (lambda (val tree)
    (cases binary-tree tree
      (leaf-node (datum)
                 (eq? val datum))
      (interior-node (key left right)
                     (or (bintree-member? val left)
                         (bintree-member? val right)))
      (else
       '(error "bintree-member?: Invalid tree" tree)))))
;; -----------------------------------------------------------
;; Problem 3
;; -----------------------------------------------------------
(define run-length-encode
  (lambda (lst)
    (letrec ((encode-helper
              (lambda (lst prev-val amt-repeat)
                (cond ((null? lst) (cons (repeats prev-val amt-repeat) '()))
                      ((eq? (car lst) prev-val) (encode-helper (cdr lst) (car lst) (+ 1 amt-repeat)))
                      (else (cons (repeats prev-val amt-repeat)
                                  (encode-helper (cdr lst) (car lst) 1)))))))
      (encode-helper lst (car lst) 0))))
(define repeats
  (lambda (prev-val amt-repeat)
    (if (>= amt-repeat 2)
        (cons prev-val amt-repeat)
        prev-val )))