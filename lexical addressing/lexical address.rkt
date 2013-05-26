(load "syntax-procedures.rkt")
(load "free-vars.rkt")
(load "list-index.rkt")


(define lexical-address
  (lambda (exp)
    (lexical-address-helper exp (list (free-vars exp)))))


(define lexical-address-helper
  (lambda (exp decls)
    (cond ((lambda? exp) (list 'lambda
                               (lambda->formals exp)
                               (lexical-address-helper (lambda->body exp)
                                                       (cons (lambda->formals exp)
                                                             decls)
                                                       )))
          ((varref? exp) (getPos exp decls 0))
          ((if? exp)  (list 'if
                            (lexical-address-helper (if->test exp) decls)
                            (lexical-address-helper (if->then exp) decls)
                            (lexical-address-helper (if->else exp) decls) ))
          ((app? exp) (map (lambda (e) 
                             (lexical-address-helper e decls ))
                           exp)))))

(define getPos
  (lambda (var decls depth)
    (if (null? decls)
        (error 'lexical-address-of
                      "variable not found in table of variables" var)
        (let ( (position (list-index var (car decls))) )
          (if (> position -1)
              (list var ': depth position)
              (getPos var (cdr decls) (+ depth 1)))))))
    



;do app and if first!!! lambda is where you hit a new block. New variable declarations. 
          
;(define lexical-address-helper
;  (lambda (exp)
    