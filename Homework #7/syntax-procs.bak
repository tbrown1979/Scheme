;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   syntax-procs.ss                                   |
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
;; |   MODIFIED BY    :                                                     |
;; |   DATE           :                                                     |
;; |   DESCRIPTION    :                                                     |
;; |                                                                        |
;;  ------------------------------------------------------------------------

;;   This code works with the following grammar:
;;
;;        <exp>      ::= <varref>
;;                     | ( lambda ( <var> ) <exp> )
;;                     | ( <exp> <exp> )

(define exp?
  (lambda (exp)
    (or (varref? exp)
        (lambda? exp)
        (app?    exp))))

(define varref? symbol?)

(define lambda?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (eq? (car exp) 'lambda)
         (varref? (caadr exp))
         (exp? (caddr exp)))))

(define lambda->parameter caadr)
(define lambda->body      caddr)

(define app?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 2)
         (exp? (car exp))
         (exp? (cadr exp)))))

(define app->procedure car)
(define app->argument  cadr)

;; ----- END OF FILE -----