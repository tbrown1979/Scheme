Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
> (string-binding? '("Eugene" eugene))
#f
> (string-binding? '(x "Eugene likes Scheme"))
#t
> (string-binding? '(eugene "1992"))
#t
> (string-binding? '(x "Eugene" y "likes scheme"))
#f
> (string-binding? '(x))
#f
> (string-binding? '(x x))
#f
> (string-binding? '("string" "otherstring"))
#f
> (string-binding? '())
#f
> 