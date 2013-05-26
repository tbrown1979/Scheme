;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   free-vars.rkt                                     |
;; |   AUTHOR         :   Eugene Wallingford                                |
;; |   CREATION DATE  :   March 14, 2013                                    |
;; |                                                                        |
;; |   DESCRIPTION    :   Takes an expression in our little language and    |
;; |                      returns a set of its free variable references.    |
;; |                                                                        |
;; |   REQUIRES       :   set-adt.rkt                                       |
;; |                  :   syntax-procedures.rkt                             |
;; |                                                                        |
;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   MODIFIED BY    :                                                     |
;; |   DATE           :                                                     |
;; |   DESCRIPTION    :                                                     |
;; |                                                                        |
;;  ------------------------------------------------------------------------

(load "syntax-procedures.rkt")
(load "set-adt.rkt")

(define free-vars
  (lambda (exp)
    (cond
      ( (varref? exp)
          (set-of exp) )
      ( (lambda? exp)
          (set-minus (free-vars (lambda->body exp))
                     (lambda->formals exp)) )
      ( (if? exp)
          (set-union (free-vars (if->test exp))
                     (set-union (free-vars (if->then exp))
                                (free-vars (if->else exp)))) )
      ( else    ;; application
          (set-union-all (map free-vars exp))) )))

;; ----- END OF FILE ------------------------------------------------------