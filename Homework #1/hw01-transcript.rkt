> Problem 2
>
> (+ (- (* 4 7) 13 ) 5 )
20
> (- (* 4 7) (+ 13 5) )
10
> (- (+ (* 4 1/6) 6.1) -2.2)
8.966666666666667
> (+ (* (- 1/6 -2.2) 4) 6.1)
15.566666666666666
>
>
> Problem 3
>
> (/ (+ -17 (sqrt (- (expt 17 2) (* 4 (* 3 -12))))) (* 2 3) )

0.6347753411141355
>
>
> Problem 5
>
> (define five (list (list 'a 'b) (list (list 'c) 'd ) ) )
> five
((a b) ((c) d))
> (car (car five ) )
a
> (car (cdr (car five ) ) )
b
> (car (car (car (cdr five ))))
c
> (car (cdr (car (cdr five ) )))
d
> 
>
> problem 6
>
>
> (define six (cons '5 (cons '4 (cons '3 (cons '(x) (cons '1 '()))))))
> six
(5 4 3 (2) 1)
> (car (car (cdr (cdr (cdr six ) ) ) ) )
x
>
>
> (define sixtwo (list '1 (list '2 (list '3) '4 '5 ) (list '6 'x '8 ) ) )
> sixtwo
(1 (2 (3) 4 5) (6 7 8))
> (car (cdr (car (cdr (cdr sixtwo ) ) ) ))
x
>
>
> (define sixthree (list (list (list '1 (list (list '2)) (list (list '3 '4) '5 ) ) ) ) )
> sixthree
(((1 ((x)) ((3 4) 5))))
> (car (car (car (cdr (car (car sixthree))))))
x
>
>
> Problem 7
>
> (define lyst (list (list 'g (list 'b 'c) 'd) 'a 'e 'f ))
> (cdr (cdr lyst))
(e f)
> (cdr (car lyst))
((b c) d)
> (car (cdr lyst))
a
>
>
