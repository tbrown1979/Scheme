Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
> (define *epsilon* 0.1)
> (in-range? 4.95 5.0)
#t
> (in-range? 5.0 4.95)
#t
> (in-range? 5.0 5.95)
#f
> (define *epsilon* 0.01)
> (in-range? 4.95 5.0)
#f
> (in-range? 4.99 5.0)
#t
> (define *epsilon* 0)
> (in-range? 5 5)
#t
> 