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

(define let->local-var 
  (lambda (let-exp)
    (binding->var (car (cdr let-exp)))))
(define let->local-var-val
  (lambda (let-exp)
    (car (car (binding->value let-exp)))))
(define let->binding cadr)
(define let->body caddr)

(define let? 
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (eq? (car exp) 'let)
         (binding? (let->binding exp))
         (exp? (let->body exp)) )))

;; -----------------------------------------------------------
;; Problem 3
;; -----------------------------------------------------------

(define let->app
  (lambda (let-exp)
    (list (list 'lambda 
                (list (let->local-var let-exp))
                (let->body let-exp) )
          (binding->value (let->binding let-exp)) )))

;; -----------------------------------------------------------
;; Problem 4
;; -----------------------------------------------------------

(define and->1st-arg cadr)
(define and->2nd-arg caddr)

(define and->if
  (lambda (and-exp)
    (list 'if (and->1st-arg and-exp) (and->2nd-arg and-exp) 'f)))

(define or->1st-arg cadr)
(define or->2nd-arg caddr)

(define or->if
  (lambda (or-exp)
    (list 'if (or->1st-arg or-exp) 't (or->2nd-arg or-exp))))



;; -----------------------------------------------------------
;; Problem 5
;; -----------------------------------------------------------

(define types-match?
  (lambda (types items)
    (types-match?-helper types items)))

(define types-match?-helper
  (lambda (types items)
    (if (null? items)
        #t
        (and ((car types) (car items))
             (types-match?-helper (if (null? (cdr types))
                                      types
                                      (cdr types))
                                  (cdr items))))))



;; -----------------------------------------------------------
;; -----------------------------------------------------------
;; -----------------------------------------------------------


'(define if-test1 '(if <exp1> <exp2> <exp3>))
(define if-test1 '(if <exp1> <exp2> <exp3>))
'(if->test if-test1)
(if->test if-test1)

'(if->then if-test1)
(if->then if-test1)

'(if->else if-test1)
(if->else if-test1)

(if? if-test1)

'(define if-test2 '(if))
(define if-test2 '(if))
(if? if-test2)

'(define if-test3 '(if <exp1> <exp2>))
(define if-test3 '(if <exp1> <exp2>))
(if? if-test3)

'(define if-test4 '(blurp <exp1> <exp2> <exp3>))
(define if-test4 '(blurp <exp1> <exp2> <exp3>))
(if? if-test4)
'(-------------------------------------------------------)   
'(let? '(let (x (lambda (x) y)) <body>))
(let? '(let (x (lambda (x) y)) <body>))
'(define let1 '(let (<var> <val>) <body>))
(define let1 '(let (<var> <val>) <body>))
(let? let1)
'(define let2 '(ex  (<var> <val>) <body>))
(define let2 '(ex  (<var> <val>) <body>))
(let? let2)
'(-------------------------------------------------------)
'(let->app '(let (a b) a))
(let->app '(let (a b) a))
'(let->app '(let (x i) (f x)))
(let->app '(let (x i) (f x)))
'(let->app '(let (a b) ((lambda (x) (a x)) a)))
(let->app '(let (a b) ((lambda (x) (a x)) a)))

'(-------------------------------------------------------)
'(and->if '(and a b))
(and->if '(and a b))

'(and->if '(and (f x) (f b)))
(and->if '(and (f x) (f b)))

'(and->if '(and ((lambda (x)
                         (f x))
                       a)
                      (f b)))
(and->if '(and ((lambda (x)
                         (f x))
                       a)
                      (f b)))
'(or->if '(or a b))
(or->if '(or a b))
'(or->if '(or (f x) (f b)))
(or->if '(or (f x) (f b)))
(or->if '(or ((lambda (x)
                        (f x))
                      a)
                     (f b)))
'(or->if '(or ((lambda (x)
                        (f x))
                      a)
                     (f b)))
'(-------------------------------------------------------)
'(types-match? (list number?)
                     (list 42     ))
(types-match? (list number?)
                     (list 42     ))
'(types-match? (list number? string?)
                     (list 42      "Hello, Eugene"))
(types-match? (list number? string?)
                     (list 42      "Hello, Eugene"))
'(types-match? (list number?  string?) ; "eugene" is not a number
              (list "eugene" "eugene"))
(types-match? (list number?  string?) ; "eugene" is not a number
              (list "eugene" "eugene"))
'(types-match? (list procedure? list?)
              (list cdr        '((6 3 8) (10 9 8) (3 4 2 6 ))))
(types-match? (list procedure? list?)
              (list cdr        '((6 3 8) (10 9 8) (3 4 2 6 ))))
'(types-match? (list list? procedure?) ; values reversed
              (list cdr   '((6 3 8) (10 9 8) (3 4 2 6 ))))
(types-match? (list list? procedure?) ; values reversed
              (list cdr   '((6 3 8) (10 9 8) (3 4 2 6 ))))
'(types-match? (list number? string?)
              (list 42 "Eugene" "Wallingford"))
(types-match? (list number? string?)
              (list 42 "Eugene" "Wallingford"))
'(types-match? (list number? string?)
              (list 42 "Eugene" 'Wallingford))
(types-match? (list number? string?)
              (list 42 "Eugene" 'Wallingford))
'(types-match? (list procedure? list?)
              (list cdr '(6 3 8) '(10 9 8) '(3 4 2 6 )))
(types-match? (list procedure? list?)
              (list cdr '(6 3 8) '(10 9 8) '(3 4 2 6 )))
'(types-match? (list number?)
                     (list '(6 3 8) 10 9 8 '(3 4 2 6 )))
(types-match? (list number?)
                     (list '(6 3 8) 10 9 8 '(3 4 2 6 )))
'(types-match? (list number?)
                     (list 6 3 8 10 9 8 3 4 2 6))
(types-match? (list number?)
                     (list 6 3 8 10 9 8 3 4 2 6))
'(types-match? '() '())
(types-match? '() '())

;(types-match? '()
;                     (list 6 3 8))
;'error