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