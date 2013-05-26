;;
;; FILE:     boom-language.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     04/07/13
;; COMMENT:  The start to our Boom language!
;;           
;;
;; MODIFIED: 04/17/2013 - Taylor Brown
;;                
;; CHANGE:  -Extended Boom with unary operators. Also added a
;;           preprocessor to de-sugar expressions.
;;
;; -----------------------------------------------------------
;; Problem 4 !!HW09!! SYNTAX PROCEDURES 
;; -----------------------------------------------------------
(define identity
  (lambda (x)
    x))
(define boom/number? number?)
(define boom/number identity)

(define boom/binary-exp->left car)
(define boom/binary-exp->right caddr)
(define boom/binary-exp->operator cadr)
(define boom/binary-exp? 
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (boom/exp? (boom/binary-exp->left exp))
         (boom/operator? (boom/binary-exp->operator exp))
         (boom/exp? (boom/binary-exp->right exp)) )))

(define *boom/operators* '(+ - * / % @))

(define boom/operator?
  (lambda (exp)
    (member exp *boom/operators*)))
;; -----------------------------------------------------------
;; NEW!!! Problem 4 !!HW10!!
;; -----------------------------------------------------------
(define boom/unary-operation car)
(define boom/unary-arg cadr)

(define boom/unary-operator?
  (lambda (exp)
    (or (eq? exp '-)
        (eq? exp 'sqrt) )))

(define boom/unary?
  (lambda (exp)
    (and (list? exp)
         (= 2 (length exp))
         (boom/unary-operator? (boom/unary-operation exp))
         (boom/exp? (boom/unary-arg exp)) )))

(define boom/unary
  (lambda (operation exp)
    (cond 
      ((eq? operation '-) (- exp))
      ((eq? operation 'sqrt) (sqrt exp)) )))
;; -----------------------------------------------------------
;; -----------------------------------------------------------
;; -----------------------------------------------------------
(define boom/expression
  (lambda (exp left right)
    (cond ((eq? exp '+) (+ left right))
          ((eq? exp '-) (- left right))
          ((eq? exp '*) (* left right))
          ((eq? exp '/) (quotient left right))
          ((eq? exp '%) (modulo left right))
          (else #f) )))

(define boom/exp?
  (lambda (exp)
    (or (boom/number? exp)
        (boom/unary? exp)
        (boom/binary-exp? exp) )))
;; -----------------------------------------------------------
;; Problem 5 EVALUATOR !!HW09!!
;; -----------------------------------------------------------
(define boom/eval
  (lambda (exp)
    (if (boom/exp? exp)
        (cond ((boom/number? exp) exp)
              ((boom/unary? exp) (boom/unary (boom/unary-operation exp) 
                                             (boom/eval (boom/unary-arg exp))))
              ((boom/binary-exp? exp) (boom/expression 
                                     (boom/binary-exp->operator exp)
                                     (boom/eval (boom/binary-exp->left exp))
                                     (boom/eval (boom/binary-exp->right exp)) )))
        (list 'boom '-- 'illegal 'expression: exp) )))
;; -----------------------------------------------------------
;; !!!NEW Problem 5 PREPROCESSOR !!HW10!!
;; -----------------------------------------------------------
(define boom/@->binary-exp
  (lambda (exp)
    (list (list (boom/binary-exp->left exp) '+ (boom/binary-exp->right exp))
          '/
          2)))
(define boom/@?
  (lambda (exp)
    (eq? (boom/binary-exp->operator exp) '@)))

(define boom/preprocess
  (lambda (exp)
    (cond 
      ((boom/number? exp) exp)
      ((boom/unary?  exp) (list (boom/unary-operation exp)
                                (boom/preprocess (boom/unary-arg exp))))
      ((boom/binary-exp? exp) (if (boom/@? exp)
                                  (boom/preprocess (boom/@->binary-exp exp))
                                  (list (boom/preprocess (boom/binary-exp->left exp))
                                        (boom/binary-exp->operator exp)
                                        (boom/preprocess (boom/binary-exp->right exp)) ))))))

