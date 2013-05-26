(load "hw08.rkt")
;; -----------------------------------------------------------
;; test cases
;; -----------------------------------------------------------
'Problem1
'(curry-lambda '(lambda (a b) ((f a) b)) )
(list (curry-lambda '(lambda (a b) ((f a) b))) '=> '(lambda (a) (lambda (b) ((f a) b))) )
'\
'(curry-lambda '(lambda (a b x) ((x a) (x b))) )
(list (curry-lambda '(lambda (a b x) ((x a) (x b)))) '=> '(lambda (a) (lambda (b) (lambda (x) ((x a) (x b))))) )
'--------------------------------------------------
'Problem2
'(curry-app '(f a b))
(list (curry-app '(f a b)) '=> '((f a) b) )
'\
'(curry-app '(+ a b c d))
(list (curry-app '(+ a b c d)) '=> '((((+ a) b) c) d) )
'\
'(curry-app '(f a))
(list (curry-app '(f a)) '=> '(f a) )
'--------------------------------------------------
'Problem3
'(pre-process 'f)
(list (pre-process 'f) '=> 'f)
'\
'(pre-process '(if a b c))
(list (pre-process '(if a b c)) '=> '(if a b c) )
'\
'(pre-process '(and a b))
(list (pre-process '(and a b)) '=> '(if a b f) )
'\
'(pre-process '(and a (or b c)))
(list (pre-process '(and a (or b c))) '=> '(if a (if b t c) f) )
'\
'(pre-process '(lambda (a) (let (x i) (and a x))))
(list (pre-process '(lambda (a)
                       (let (x i)
                         (and a x))))
      '=>
      '(lambda (a)
         ( (lambda (x)
             (if a x f))
           i )) )
'\
'(pre-process '(f a b))
(list (pre-process '(f a b)) '=> '((f a) b))
'\
'(pre-process '(f (f a a) (f b b)))
(list (pre-process '(f (f a a) (f b b))) '=> '((f ((f a) a)) ((f b) b)))
'--------------------------------------------------
'Problem4
'((type-checked sqrt number?) 100)
(list ((type-checked sqrt number?) 100) '=> 10 )
'\
'(define type-safe-sqrt (type-checked sqrt number?))
(define type-safe-sqrt (type-checked sqrt number?))
'(type-safe-sqrt 144)
(list (type-safe-sqrt 144) '=> 12)
'(type-safe-sqrt "144")
(list (type-safe-sqrt "144") '=> 'ERROR)
'\
'(define type-safe-+ (type-checked + number?))
(define type-safe-+ (type-checked + number?))
'(type-safe-+ 1 2 3 4 5)
(list (type-safe-+ 1 2 3 4 5) '=> 15)
'(type-safe-+ 1 2 'a 4 5)
(list (type-safe-+ 1 2 'a 4 5) '=> 'ERROR)
'\
'(define safe-expt (type-checked expt number?))
(define safe-expt (type-checked expt number?))
'(safe-expt 5 3)
(list (safe-expt 5 3) '=> 125)
'(safe-expt 5 "3")
(list (safe-expt 5 "3") '=> 'ERROR)
'\
'(define safe-map (type-checked map procedure? list?))
(define safe-map (type-checked map procedure? list?))
'(safe-map sqrt '(1 4 9 16))
(list (safe-map sqrt '(1 4 9 16)) '=> '(1 2 3 4))
'(safe-map 'sqrt '(1 4 9 16))
(list (safe-map 'sqrt '(1 4 9 16)) '=> 'ERROR)
'--------------------------------------------------
; -----------------------------------------------------------