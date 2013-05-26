;;
;; FILE:     homework08.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     03/29/13
;; COMMENT:  More syntactic abstractions
;;           
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;
(load "syntax-procs.rkt")
(load "types-match.rkt")
;; -----------------------------------------------------------
;; Problem 1
;; -----------------------------------------------------------
(define curry-lambda
  (lambda (lambda-exp)
    (if (null? (lambda->parameters-minus-1st lambda-exp) )
        lambda-exp
        (list 'lambda 
              (list (lambda->1st-parameter lambda-exp) )
              (curry-lambda (list 'lambda 
                                  (lambda->parameters-minus-1st lambda-exp)
                                  (lambda->body lambda-exp) ))))))

(define lambda->parameters cadr)
(define lambda->1st-parameter caadr)
(define lambda->parameters-minus-1st cdadr)

(define change-lambda-params
  (lambda (lambda-exp new-params)
    (list 'lambda new-params (lambda->body lambda-exp)) ))
;; -----------------------------------------------------------
;; Problem 2
;; -----------------------------------------------------------
(define curry-app
  (lambda (app-exp)
    (curry-app-helper (reverse app-exp))))

(define curry-app-helper
  (lambda (app-exp)
    (if (null? (cdr app-exp))
        (app->procedure app-exp)
        (list (curry-app-helper (cdr app-exp)) (car app-exp)))))

;; -----------------------------------------------------------
;; Problem 3
;; -----------------------------------------------------------
(define pre-process
  (lambda (exp)
    (cond
      ((varref? exp) exp)
      ((lambda? exp) (list 'lambda
                           (lambda->parameters (curry-lambda exp))
                           (pre-process (lambda->body (curry-lambda exp))) ))
      ((if? exp) (list 'if
                       (pre-process (if->test exp))
                       (pre-process (if->then exp))
                       (pre-process (if->else exp))))
      ((let? exp) (pre-process (let->app exp)))
      ((and? exp) (pre-process (and->if  exp)))
      ((or?  exp) (pre-process (or->if   exp)))
      (else (list (pre-process (app->procedure (curry-app exp)))  
                  (pre-process (app->argument  (curry-app exp))) ))
      
      )))
;; -----------------------------------------------------------
;; Problem 4
;; -----------------------------------------------------------
(define type-checked
  (lambda types
    (lambda args
      (if (types-match? (cdr types) args)
          (apply (car types) args)
          (list 'type 'mismatch (car types) (cdr types) args)
          ))))
;; -----------------------------------------------------------
;; and/or ---> if
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
;; let--->app
;; -----------------------------------------------------------
(define let->app
  (lambda (let-exp)
    (list (list 'lambda 
                (list (let->variable let-exp))
                (let->body let-exp) )
          (let->value let-exp)) ))

(define let->variable caadr)
(define let->value cadadr)
(define let->body caddr)
;; -----------------------------------------------------------
;; types-match?
;; -----------------------------------------------------------
(define types-match?
  (lambda (types items)
    (cond
      ((and (null? types) (null? items)) #t)
      ((null? items) #f)
      (else (types-match?-helper types items)))))
        
(define types-match?-helper
  (lambda (types items)
    (if (and (>= 1 (length types)) (null? items))
        #t
        (and ((car types) (car items))
             (types-match?-helper (if (null? (cdr types))
                                      types
                                      (cdr types))
                                  (cdr items))))))