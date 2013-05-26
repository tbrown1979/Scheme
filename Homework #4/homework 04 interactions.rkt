Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
> (detect positive? '(1 -1 2 -2 3 -3 4 -4 -5))
1
> (detect boolean? (list 1 'a 't #t "false" #f '(a . b)))
#t
> (detect number? (list 'a 't #t '(1 2 3) "false" #f '(a . b)))
#f
> (detect pair? (list 'a 't #t '(1 2 3) "false" #f '(a . b)))
(1 2 3)
> (detect (lambda (x)
                 (not (number? x)))
               (list 1 'a 't #t '(1 2 3) "false" #f '(a . b)))
a
> (detect (lambda (n)
                 (> n 1008))
               (sequence 1000 1010))
1009
> (detect (lambda (x)
            (not (eq? x x)))
           (list 1 'a 't #t '(1 2 3) "false" #f '(a . b)))
#f
> (positions-of 'a '(a b a c d a e f g a h i j k))
(1 3 6 10)
> 