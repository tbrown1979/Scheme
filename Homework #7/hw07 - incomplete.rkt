(load "syntax-procs.rkt")


;; -----------------------------------------------------------
;; Problem 1
;; -----------------------------------------------------------
(define if->test cadr)
(define if->then caddr)
(define if->else cadddr)

(define if?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 4)
         (eq? (car exp) 'if)
         (exp? (if->test exp ))
         (exp? (if->then exp))
         (exp? (if->else exp)) )))


;(define if '(if <exp1> <exp2> <exp3>))
;(define if2 '(if))
;(define if3 '(if <exp1> <exp2>))
;(define if4 '(blurp <exp1> <exp2> <exp3>))


;; -----------------------------------------------------------
;; Problem 2
;; -----------------------------------------------------------

(define binding->var car)
(define binding->value cadr)

(define binding?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 2)
         (varref? (binding->var exp))
         (exp? (binding->value exp )) )))

(define let->binding cadr)
(define let->body caddr)

(define let? 
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (eq? (car exp) 'let)
         (binding? (let->binding exp))
         (exp? (let->body exp)) )))
;         
(let? '(let (x (lambda (x) y)) <body>)) 
;(define let '(let (<var> <val>) <body>))
;(define let2 '(ex  (<var> <val>) <body>))
;
;(let? '(let ('x (lambda (x) 'y)) <body>))
