;;
;; FILE:     boom-language.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     04/07/13
;; COMMENT:  The start to our Boom language!
;;           
;;          Date: 4/17/2013 - Taylor Brown
;; CHANGE:  -Extended Boom with unary operators. Also added a
;;           preprocessor to de-sugar expressions.
;;
;;          Date: 4/24/2013 - Taylor Brown 
;;          -Extended boom with variables and primitive types
;;
;;          Date: 4/24/2013 - Taylor Brown 
;;          -Extended boom with begin-end exp. Changed how an environment works.
;;           Added a REPL, and also extended the language with begin-end exp.
;;           If expressions were also added. Along with boolean. This still 
;;           needs some work. Also added two more operators that work with nums.
;;
;;   
;;          Boom's grammar:
;;
;;   <exp>      ::= <number>  
;;                | <boolean>                              Added HW 12
;;                | ( <unary-operator> <exp> )
;;                | ( <exp> <operator> <exp> )
;;                | <variable>                             Added HW 11
;;                | ( with <var> = <exp> do <exp> )        Added HW 11
;;                | ( <variable> <= <exp> )
;;                | ( begin <exp>+ end )                   Added HW 12
;;                | ( if <exp> <exp> <exp> )               Added HW 12
;;
;;   <boolean> ::= @f | @t
;;   <unary-operator> ::= - | sqrt
;;   <operator> ::= + | - | * | / | % | @ | > | < 
;;                                          ^---^
;;                                            | ----- Added HW 12
;;           
;;  ----------------------------------------------------------
(define identity
  (lambda (x)
    x))
(define compose
  (lambda (f g)
    (lambda (lst)
      (f (g lst)))))
(define remove-last
  (lambda (lst)
    (if (null? (cdr lst))
        '()
        (cons (car lst) (remove-last (cdr lst))))))
(define last
    (lambda (lst)
      (if (null? (cdr lst))
          (car lst)
          (last (cdr lst)))))
;; -----------------------------------------------------------
;; Cell
;; -----------------------------------------------------------
(define cell
  (lambda (init-value)
    (let ((cell-value (lambda ()
                        init-value))
          (cell-set!  (lambda (new-val)
                        (set! init-value new-val)
                        init-value)) )
      (cons cell-value cell-set!))))

(define cell-value
  (lambda (cell)
    ((cell->value cell))))

(define cell-set!
  (lambda (cell new-val)
    ((cell->set! cell) new-val)))

(define cell->value car)
(define cell->set!  cdr)
;; -----------------------------------------------------------
;; Bindings
;; -----------------------------------------------------------
(define bindings
  (lambda ()
    '()))

(define bind
  (lambda (name value ff)
    (cons (cons name (cell value)) ff)))

(define bind* 
  (lambda (name-lst val-lst ff)
    (if (null? name-lst)
        ff
        (bind (car name-lst) (car val-lst)
              (bind* (cdr name-lst) (cdr val-lst) ff)))))

(define bind->name car)
(define bind->val  cdr)

(define look-up
  (lambda (env name)
    (let ((value (assoc name env)))
      (if value 
           ((cell->value (bind->val value))) ; FIX THIS
          (list 'error "environment does not contain variable" name)))))

(define set-val!
  (lambda (env name new-val)
    (let ((cell-to-! (assoc name env)))
      (if cell-to-!
          (cell-set! (cdr cell-to-!) new-val)
          (list 'error "environment does not contain variable" name)))))
;; -----------------------------------------------------------
;; varref
;; -----------------------------------------------------------
(define boom/varref? symbol?)
(define boom/primitives (bind 'pi 3.1415927 (bind 'e 2.7182818 (bindings))))
;; -----------------------------------------------------------
;; Number
;; -----------------------------------------------------------
(define boom/number? number?)
(define boom/number->val identity)
;; -----------------------------------------------------------
;; Boolean
;; -----------------------------------------------------------
(define boom/boolean?
  (lambda (exp)
    (and (symbol? exp)
         (or (eq? exp '@f)
             (eq? exp '@t)))))
(define boom/boolean->val identity)
(define t/f
  (lambda (exp)
    (not (eq? exp '@f))))
(define boom/@t-@f
  (lambda (exp)
    (if exp
        '@t
        '@f)))
;; -----------------------------------------------------------
;; If
;; -----------------------------------------------------------
(define boom/if?
  (lambda (exp)
    (and (list? exp)
         (eq? (length exp) 4)
         (eq? (car exp) 'if)
         (boom/exp? (boom/if->test exp))
         (boom/exp? (boom/if->then exp))
         (boom/exp? (boom/if->else exp)) )))
(define boom/if->test cadr)
(define boom/if->then caddr)
(define boom/if->else cadddr)
;; -----------------------------------------------------------
;; Binary-exp
;; -----------------------------------------------------------
(define boom/binary-exp->left car)
(define boom/binary-exp->right caddr)
(define boom/binary-exp->operator cadr)
(define boom/binary-exp? 
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (boom/exp? (boom/binary-exp->left exp))
         (boom/operator? (boom/binary-exp->operator exp))
         (boom/exp? (boom/binary-exp->right exp)) )))

(define boom/@->binary-exp
  (lambda (exp)
    (list (list (boom/binary-exp->left exp) 
                '+ 
                (boom/binary-exp->right exp))
          '/
          2)))
;; -----------------------------------------------------------
;; Operators
;; -----------------------------------------------------------
(define *boom/operators* '(+ - * / % @ < >))

(define boom/operator?
  (lambda (exp)
    (member exp *boom/operators*)))

(define boom/divide
  (lambda (left right)
    (if (and (exact? left) (exact? right))
        (quotient left right)
        (/        left right ) )))

(define boom/expression
  (lambda (exp left right)
    (cond ((eq? exp '+ ) (+  left right))
          ((eq? exp '- ) (-  left right))
          ((eq? exp '* ) (*  left right))
          ((eq? exp '/ ) (boom/divide left right))
          ((eq? exp '% ) (modulo left right))
          ((eq? exp '< ) (boom/@t-@f (<  left right)))
          ((eq? exp '> ) (boom/@t-@f (>  left right)))
          (else #f) )))

(define boom/@?
  (lambda (exp)
    (eq? (boom/binary-exp->operator exp) '@)))
;; -----------------------------------------------------------
;; Unary-operators
;; -----------------------------------------------------------
(define boom/unary-operation car)
(define boom/unary-arg cadr)

(define boom/unary-operator?
  (lambda (exp)
    (or (eq? exp '-)
        (eq? exp 'sqrt) )))

(define boom/unary?
  (lambda (exp)
    (and (list? exp)
         (= 2 (length exp))
         (boom/unary-operator? (boom/unary-operation exp))
         (boom/exp? (boom/unary-arg exp)) )))

(define boom/unary
  (lambda (operation exp)
    (cond 
      ((eq? operation '-) (- exp))
      ((eq? operation 'sqrt) (sqrt exp)) )))
                   
;; -----------------------------------------------------------
;; with-do
;; -----------------------------------------------------------
(define boom/with-do?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 6)
         (eq? 'with (car exp))
         (boom/varref? (boom/with->varref exp))
         (eq? '= (caddr exp))
         (boom/exp? (boom/with->value exp))
         (eq? 'do (car (cddddr exp)))
         (boom/exp? (boom/with->body exp)) )))

(define cadddddr 
  (lambda (lst)
    (car (cdr (cddddr lst)))))
(define boom/with->varref cadr)
(define boom/with->value  cadddr)
(define boom/with->body   cadddddr)

;; -----------------------------------------------------------
;; assignment expression
;; -----------------------------------------------------------
(define boom/assign?
  (lambda (exp)
    (and (list? exp)
         (= (length exp) 3)
         (boom/varref? (boom/assign->var exp))
         (eq? (boom/assign->2 exp) '<=)
         (boom/exp? (boom/assign->value exp)))))
(define boom/assign->var   car)
(define boom/assign->2     cadr)
(define boom/assign->value caddr)
;; -----------------------------------------------------------
;; Begin/End
;; -----------------------------------------------------------
(define boom/begin-end?
  (lambda (exp)
    (and (list? exp)
         (>= (length exp) 3)
         (eq? (boom/begin-end->1 exp)         'begin)
         (boom/begin-end-exp? (boom/begin-end->exp exp))
         (eq? (boom/begin-end-><end> exp)     'end) )))

(define boom/begin-end-><end> last)
(define boom/begin-end->1 car)
(define boom/begin-end->exp (compose remove-last cdr))

(define boom/begin-end->1st-exp cadr)
(define boom/begin-end->minus-1st-exp cddr)
(define boom/begin-end-single-exp? 
  (lambda (begin-end)
    (<= (length (boom/begin-end->exp begin-end)) 1)))

(define boom/begin-end-exp?
  (lambda (exp+)
    (if (null? exp+)
        #t
        (and (boom/exp?       (car exp+)) 
             (boom/begin-end-exp? (cdr exp+))))))
(define boom/pp-begin-end-exps
  (lambda (loe)
    (if (eq? (car loe) 'end)
        (cons 'end '())
        (cons (boom/preprocess (car loe)) (boom/pp-begin-end-exps (cdr loe))) )))
;; -----------------------------------------------------------
;; Boom expression?
;; -----------------------------------------------------------
(define boom/exp?
  (lambda (exp)
    (or (boom/number?     exp)
        (boom/unary?      exp)
        (boom/binary-exp? exp)
        (boom/varref?     exp)
        (boom/with-do?    exp)
        (boom/assign?     exp)
        (boom/begin-end?  exp)
        (boom/boolean?    exp)
        (boom/if?         exp) )))
;; -----------------------------------------------------------
;; Evaluator
;; -----------------------------------------------------------
(define boom/eval
  (lambda (exp)
    (boom/eval-exp (boom/preprocess exp) boom/primitives)))

(define boom/eval-exp
  (lambda (exp env)
    (cond ((boom/number?     exp) (boom/number->val                exp))
          ((boom/boolean?    exp) (boom/boolean->val               exp))
          ((boom/unary?      exp) (boom/eval-unary             exp env))
          ((boom/binary-exp? exp) (boom/eval-binary-exp        exp env))
          ((boom/varref?     exp) (boom/eval-exp (look-up env exp) env))
          ((boom/with-do?    exp) (boom/eval-with-do           exp env))
          ((boom/assign?     exp) (boom/eval-assign            exp env))
          ((boom/begin-end?  exp) (boom/eval-begin-end         exp env))
          ((boom/if?         exp) (boom/eval-if                exp env))
          (else (list 'boom '-- 'illegal 'expression: exp) ))))

(define boom/eval-binary-exp
  (lambda (exp env)
    (boom/expression 
     (boom/binary-exp->operator exp)
     (boom/eval-exp (boom/binary-exp->left exp ) env)
     (boom/eval-exp (boom/binary-exp->right exp) env) )))

(define boom/eval-unary
  (lambda (exp env)
    (boom/unary (boom/unary-operation exp) 
                (boom/eval-exp (boom/unary-arg exp) env))))

(define boom/eval-with-do
  (lambda (exp env)
    (boom/eval-exp (boom/with->body exp)
                   (bind (boom/with->varref exp)
                         (boom/with->value  exp)
                         env))))

(define boom/eval-assign
  (lambda (exp env) 
    (let ((evaluated-val (boom/eval-exp (boom/assign->value exp) env)))
      (set-val! env (boom/assign->var exp) evaluated-val) )))

(define boom/eval-begin-end
  (lambda (exp env)
    (cond ((boom/begin-end-single-exp? exp)
           (boom/eval-exp (boom/begin-end->1st-exp exp) env))
          (else (boom/eval-exp (boom/begin-end->1st-exp exp) env)
                (boom/eval-exp (cons 'begin (boom/begin-end->minus-1st-exp exp)) env)))))

(define boom/eval-if
  (lambda (exp env)
    (if (t/f (boom/eval-exp (boom/if->test exp) env))
        (boom/eval-exp (boom/if->then exp) env)
        (boom/eval-exp (boom/if->else exp) env))))
;; -----------------------------------------------------------
;; Preprocess
;; -----------------------------------------------------------
(define boom/preprocess
  (lambda (exp)
    (cond ((boom/number?      exp) (boom/number->val   exp))
          ((boom/boolean?     exp) (boom/boolean->val  exp))
          ((boom/unary?       exp) (boom/pp-unary      exp))
          ((boom/binary-exp?  exp) (boom/pp-binary-exp exp))
          ((boom/varref?      exp)                     exp)
          ((boom/with-do?     exp) (boom/pp-with-do    exp))
          ((boom/assign?      exp) (boom/pp-assign     exp))
          ((boom/begin-end?   exp) (boom/pp-begin-end  exp))
          ((boom/if?          exp) (boom/pp-if         exp))
          (else  (list 'boom '-- 'illegal 'expression: exp)) )))

(define boom/pp-binary-exp
  (lambda (exp)
    (if (boom/@? exp)
        (boom/preprocess (boom/@->binary-exp exp))
        (list (boom/preprocess (boom/binary-exp->left exp))
              (boom/binary-exp->operator exp)
              (boom/preprocess (boom/binary-exp->right exp)) ))))

(define boom/pp-unary
  (lambda (exp)
    (list (boom/unary-operation exp)
          (boom/preprocess (boom/unary-arg exp)))))

(define boom/pp-with-do
  (lambda (exp)
    (list 'with 
          (boom/with->varref exp) 
          '= 
          (boom/preprocess (boom/with->value exp))
          'do
          (boom/preprocess (boom/with->body exp)))))

(define boom/pp-assign
  (lambda (exp)
    (list (boom/assign->var exp)
          '<=
          (boom/preprocess (boom/assign->value exp)))))

(define boom/pp-begin-end
  (lambda (exp)
    (cons 'begin (boom/pp-begin-end-exps (cdr exp)))))

(define boom/pp-if
  (lambda (exp)
    (list 'if 
          (boom/preprocess (boom/if->test exp))
          (boom/preprocess (boom/if->then exp))
          (boom/preprocess (boom/if->else exp)) )))
 ;; -----------------------------------------------------------
;; REPL
;; -----------------------------------------------------------
(define boom/run
  (lambda ()
    (display (boom/eval (read)))
    (newline)
    (boom/run)))