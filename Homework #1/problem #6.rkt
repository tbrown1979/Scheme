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