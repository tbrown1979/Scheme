;;
;; FILE:     boom-language.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     04/07/13
;; COMMENT:  The start to our Boom language!
;;           
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;
;; -----------------------------------------------------------
;; Problem 4
;; -----------------------------------------------------------
(define boom/number? number?)

(define boom/equation->left-exp car)
(define boom/equation->right-exp caddr)
(define boom/equation->operator cadr)
(define boom/equation? 
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (boom/exp? (boom/equation->left-exp exp))
         (boom/operator? (boom/equation->operator exp))
         (boom/exp? (boom/equation->right-exp exp)) )))

(define boom/operator?
  (lambda (exp)
    (not (eq? (boom/operator exp) -1))))

(define boom/operator
  (lambda (exp)
    (cond ((eq? exp '+) +)
          ((eq? exp '-) -)
          ((eq? exp '*) *)
          ((eq? exp '/) quotient)
          ((eq? exp '%) modulo)
          (else -1))))

(define boom/exp?
  (lambda (exp)
    (or (boom/number? exp)
        (boom/equation? exp))))
;; -----------------------------------------------------------
;; Problem 5
;; -----------------------------------------------------------
(define boom/eval
  (lambda (exp)
    (if (boom/exp? exp)
        (cond ((boom/number? exp) exp)
              ((boom/equation? exp) ((boom/operator (boom/equation->operator exp))
                                     (boom/eval (boom/equation->left-exp exp))
                                     (boom/eval (boom/equation->right-exp exp)))))
        (list 'boom '-- 'illegal 'expression: exp))))