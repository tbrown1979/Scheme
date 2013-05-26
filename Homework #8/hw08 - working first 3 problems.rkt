(load "syntax-procs.rkt")
(load "desugar.rkt")
(load "types-match.rkt")

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

;;  ------------------------------------------------------------------------

(define curry-app
  (lambda (app-exp)
    (curry-app-helper (reverse app-exp))));made interface so it wouldn't have to reverse with every recursion

(define curry-app-helper
  (lambda (app-exp)
    (if (null? (cdr app-exp))
        (app->procedure app-exp)
        (list (curry-app-helper (cdr app-exp)) (car app-exp)))))

;;  ------------------------------------------------------------------------

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
      (else (list (pre-process (app->procedure (curry-app exp)))         ;;;;;;;;this may need to be changed............
                  (pre-process (app->argument  (curry-app exp))) ))
      
      )))

;;  ------------------------------------------------------------------------

(define type-checked
  (lambda types
    (lambda args
      (if (types-match? (cdr types) args)
          (apply (car types) args)
          'stuff
          ))))

                     