Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
> (define sum-of-modulo10
    (sum-of (curried-modulo 10)))
> (sum-of-modulo10 1)
1
> (sum-of-modulo10 1 2 11 12 21 22)
9
> (sum-of-modulo10 10 10 10 10 10 10)
0
> (sum-of-modulo10 5 10 5)
10
> 