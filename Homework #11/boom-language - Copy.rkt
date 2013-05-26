;;
;; FILE:     boom-language.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     04/07/13
;; COMMENT:  The start to our Boom language!
;;           
;;
;; MODIFIED: 04/17/2013 - Taylor Brown
;;           04/24/2013 - Taylor Brown
;;                
;; CHANGE:  -Extended Boom with unary operators. Also added a
;;           preprocessor to de-sugar expressions.
;;          
;;          -Extended boom with variables and primitive types
;;
(define member? ;;I wrote this because (member) returns a list if true
  (lambda (exp lst)
    (if (member exp lst)
        #t
        #f)))
(define cadddddr 
  (lambda (lst)
    (car (cdr (cddddr lst)))))
(define identity
  (lambda (x)
    x))
;; -----------------------------------------------------------
;; Problem 1 !!HW11!! FF ADT
;; -----------------------------------------------------------
(define bindings
  (lambda ()
    '()))

(define bind
  (lambda (name value ff)
    (cons (cons name value) ff)))

(define bind* 
  (lambda (name-lst val-lst ff)
    (if (null? name-lst)
        ff
        (bind (car name-lst) (car val-lst)
              (bind* (cdr name-lst) (cdr val-lst) ff)))))

(define look-up
  (lambda (env name)
    (let ((value (assoc name env)))
      (if value 
          (cdr value)
          (list 'error "environment does not contain variable" name)))))
;; -----------------------------------------------------------
;; Problem 2 !!HW11!! Boom Primitives / varrefs
;; -----------------------------------------------------------
;(define *boom/primitives* '(pi e))

(define boom/varref? symbol?)
(define boom/primitives (bind 'pi 3.1415927 (bind 'e 2.7182818 (bindings))))
;; -----------------------------------------------------------
;; Problem 4 !!HW11!! with-do
;; -----------------------------------------------------------
(define boom/with-do?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 6)
         (eq? 'with (car exp))
         (boom/varref? (boom/with->varref exp))
         (eq? '= (caddr exp))
         (boom/exp? (boom/with->value exp))
         (eq? 'do (car (cddddr exp)))
         (boom/exp? (boom/with->body exp)) )))

(define boom/with->varref cadr)
(define boom/with->value cadddr)
(define boom/with->body cadddddr)
;; -----------------------------------------------------------
;; Problem 4 !!HW09!! SYNTAX PROCEDURES 
;; -----------------------------------------------------------
(define boom/number? number?)
(define boom/number->val identity)

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
(define boom/@->binary-exp
  (lambda (exp)
    (list (list (boom/binary-exp->left exp) 
                '+ 
                (boom/binary-exp->right exp))
          '/
          2)))

(define boom/@?
  (lambda (exp)
    (eq? (boom/binary-exp->operator exp) '@)))
;; -----------------------------------------------------------
;; ------  UPDATED  ------------------------------------------
(define boom/divide
  (lambda (left right)
    (if (and (exact? left) (exact? right))
        (quotient left right)
        (/        left right ) )))

(define boom/expression
  (lambda (exp left right)
    (cond ((eq? exp '+) (+ left right))
          ((eq? exp '-) (- left right))
          ((eq? exp '*) (* left right))
          ((eq? exp '/) (boom/divide left right))
          ((eq? exp '%) (modulo left right))
          (else #f) )))

(define boom/exp?
  (lambda (exp)
    (or (boom/number? exp)
        (boom/unary? exp)
        (boom/binary-exp? exp)
        (boom/varref? exp)
        (boom/with-do? exp)
         )))
;; -----------------------------------------------------------
;; Problem 4 EVALUATOR !!HW11!!
;; -----------------------------------------------------------
(define boom/eval
  (lambda (exp)
    (boom/eval-exp (boom/preprocess exp) boom/primitives)))
(define boom/eval-unary
  (lambda (exp env)
    (boom/unary (boom/unary-operation exp) 
                (boom/eval-exp (boom/unary-arg exp) env))))

(define boom/eval-binary-exp
  (lambda (exp env)
    (boom/expression 
     (boom/binary-exp->operator exp)
     (boom/eval-exp (boom/binary-exp->left exp ) env)
     (boom/eval-exp (boom/binary-exp->right exp) env) )))

(define boom/eval-with-do
  (lambda (exp env)
    (boom/eval-exp (boom/with->body exp)
                   (bind (boom/with->varref exp)
                         (boom/with->value  exp)
                         env))))

(define boom/eval-exp
  (lambda (exp env)
    (cond ((boom/number? exp)     (boom/number->val exp))
          ((boom/unary?  exp)     (boom/eval-unary exp env))
          ((boom/binary-exp? exp) (boom/eval-binary-exp exp env))
          ((boom/varref?     exp) (boom/eval-exp (look-up env  exp) env))
          ((boom/with-do?    exp) (boom/eval-with-do exp env))
          (else (list 'boom '-- 'illegal 'expression: exp) ))))
;; -----------------------------------------------------------
;; !!!NEW Problem 5 PREPROCESSOR Updated for HW11
;; -----------------------------------------------------------
(define boom/pp-binary-exp
  (lambda (exp)
    (if (boom/@? exp)
        (boom/preprocess (boom/@->binary-exp exp))
        (list (boom/preprocess (boom/binary-exp->left exp))
              (boom/binary-exp->operator exp)
              (boom/preprocess (boom/binary-exp->right exp)) ))))

(define boom/pp-with-do
  (lambda (exp)
    (list 'with 
          (boom/with->varref exp) 
          '= 
          (boom/preprocess (boom/with->value exp))
          'do
          (boom/preprocess (boom/with->body exp)))))

(define boom/pp-unary
  (lambda (exp)
    (list (boom/unary-operation exp)
          (boom/preprocess (boom/unary-arg exp)))))

(define boom/preprocess
  (lambda (exp)
    (cond ((boom/number?      exp) (boom/number->val   exp))
          ((boom/unary?       exp) (boom/pp-unary      exp))
          ((boom/binary-exp?  exp) (boom/pp-binary-exp exp))
          ((boom/varref?      exp)                     exp)
          ((boom/with-do?     exp) (boom/pp-with-do    exp)) 
          (else (list 'boom '-- 'illegal 'expression: exp)) )))

