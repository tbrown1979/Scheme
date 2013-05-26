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

(define let->app;;;;;;;;;;;USE THE NEW SYNTAX PROCEDURE WALLINGFORD PROVIDED
  (lambda (let-exp);;;;;DO NOT FORGET
    (list (list 'lambda 
                (list (let->variable let-exp))
                (let->body let-exp) )
          (let->value let-exp)) ))

(define let->variable caadr)
(define let->value cadadr)
(define let->body caddr)