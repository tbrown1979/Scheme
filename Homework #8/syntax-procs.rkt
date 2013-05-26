;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   syntax-procs.rkt                                  |
;; |   AUTHOR         :   Eugene Wallingford                                |
;; |   CREATION DATE  :   February 17, 2004                                 |
;; |                                                                        |
;; |   DESCRIPTION    :   These procedures implement standard syntax        |
;; |                      functions for a simplified grammar consisting     |
;; |                      only of variable references, if expressions,      |
;; |                      lambda expressions, applications.                 |
;; |                                                                        |
;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   MODIFIED BY    :   March 8, 2013                                     |
;; |   DATE           :   Eugene Wallingford                                |
;; |   DESCRIPTION    :   Extended the language to include boolean          |
;; |                      values and boolean connectives.                   |
;; |                                                                        |
;;  ------------------------------------------------------------------------

;;   LL's grammar:
;;
;;   <exp>      ::= <varref>                         CORE
;;                | <boolean>                        CORE     (new)
;;                | ( lambda ( <varref> ) <exp> )    CORE
;;                | ( <exp> <exp> )                  CORE
;;                | ( if <exp> <exp> <exp> )         CORE     (HW 07)
;;                | ( let (<var> <exp>) <exp> )      ABSTRACT (HW 07)
;;                | ( and <exp> <exp> )              ABSTRACT (new)
;;                | ( or <exp> <exp> )               ABSTRACT (new)
;;
;;    <boolean> ::= t | f                            CORE     (new)
;;
;;    <binding> ::= (<var> <exp>)                    ABSTRACT (HW 07)

;;  ------------------------------------------------------------------------

(define varref? symbol?)

;;  ------------------------------------------------------------------------

(define boolean-exp?
  (lambda (exp)
    (and (symbol? exp)
         (or (eq? 't exp)
             (eq? 'f exp)))))

;;  ------------------------------------------------------------------------

(define lambda?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (eq? (car exp) 'lambda)
         (varref? (caadr exp))
         (exp? (caddr exp)))))

(define lambda->parameter caadr)
(define lambda->body      caddr)

;;  ------------------------------------------------------------------------

(define app?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 2)
         (exp? (car exp))
         (exp? (cadr exp)))))

(define app->procedure car)
(define app->argument  cadr)

;;  ------------------------------------------------------------------------

(define if?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 4)
         (eq? (car exp) 'if)
         (exp? (cadr exp))
         (exp? (caddr exp))
         (exp? (cadddr exp)))))

(define if->test cadr)
(define if->then caddr)
(define if->else cadddr)

;;  ------------------------------------------------------------------------

(define let?
  (lambda (exp)
    (let ((binding? (lambda (exp)
                      (and (list? exp)
                           (= 2 (length exp))
                           (symbol? (car exp))
                           (exp?    (cadr exp))))))
      (and (list? exp)
           (= 3 (length exp))
           (eq? 'let (car exp))
           (binding? (cadr exp))
           (exp?     (caddr exp))))))

(define let->variable caadr)
(define let->value    cadadr)
(define let->body     caddr)

;; --------------------------------------------------------------------------

(define and?
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (eq? 'and (car exp))
         (exp? (cadr exp))
         (exp? (caddr exp)))))

(define or?
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (eq? 'or (car exp))
         (exp? (cadr exp))
         (exp? (caddr exp)))))

(define and->clauses cdr)
(define or->clauses  cdr)

;;  ------------------------------------------------------------------------

(define exp?
  (lambda (exp)
    (or (boolean-exp? exp)
        (varref? exp)
        (lambda? exp)
        (app? exp)
        (if? exp)         ;; you write this for HW 07
        (let? exp)        ;; you write this for HW 07
        (and? exp)
        (or? exp))))

;; ----- END OF FILE -----