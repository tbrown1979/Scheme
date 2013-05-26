;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   syntax-procs.rkt                                  |
;; |   AUTHOR         :   Eugene Wallingford                                |
;; |   CREATION DATE  :   March 14, 2013                                    |
;; |                                                                        |
;; |   DESCRIPTION    :   These procedures implement standard syntax        |
;; |                      functions for a simplified grammar consisting     |
;; |                      only of variable references, lambda expressions,  |
;; |                      applications, and if expressions.                 |
;; |                                                                        |
;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   MODIFIED BY    :                                                     |
;; |   DATE           :                                                     |
;; |   DESCRIPTION    :                                                     |
;; |                                                                        |
;;  ------------------------------------------------------------------------

;;
;;   This code works with the following grammar:
;;
;;        <exp>        ::= <varref>
;;                       | ( lambda <parameters> <exp> )
;;                       | <exp-list>
;;                       | ( if <exp> <exp> <exp> )
;;
;;        <parameters> ::= ()
;;                       | (<var> . <parameters>)
;;
;;        <exp-list>   ::= (<exp>)
;;                       | (<exp> . <exp-list>)
;;

;;  ------------------------------------------------------------------------
;;  exp

(define exp?
  (lambda (exp)
    (or (varref? exp)
        (lambda? exp)
        (app?    exp)
        (if?     exp))))

;;  ------------------------------------------------------------------------
;;  varref

(define varref? symbol?)

;;  ------------------------------------------------------------------------
;;  lambda

(define lambda?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (eq? (car exp) 'lambda)
         (every? varref? (cadr exp))
         (exp? (caddr exp)))))

(define lambda->formals cadr)
(define lambda->body    caddr)

;;  ------------------------------------------------------------------------
;;  application

(define app?
  (lambda (exp)
    (and (list? exp)
         (>= (length exp) 1)
         (every? exp? exp))))

(define app->procedure car)
(define app->arguments cdr)

;;  ------------------------------------------------------------------------
;;  application

(define if?
  (lambda (exp)
    (and (list? exp)
         (eq? (car exp) 'if)
         (= (length exp) 4)
         (every? exp? (cdr exp)))))

(define if->test cadr)
(define if->then caddr)
(define if->else cadddr)

;;  ------------------------------------------------------------------------
;;  utilities

(define every?
  (lambda (test? lst)
    (or (null? lst)
        (and(test? (car lst))
            (every? test? (cdr lst))))))

;; ----- END OF FILE -------------------------------------------------------