Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
>
> Problem 1
>
> (candy-temperature 244 5280)
233.44
> (candy-temperature 302 977.69)
300.04462
> (candy-temperature 302 -1401)
304.802
> (candy-temperature 250 0)
250
> (candy-temperature 10 10500) ;Should go below 0 degrees
-11.0
> (candy-temperature 10 5500) ;Should go below 0 degrees
-1.0
> (grade 0.95 0.75 0.8)
0.835
> (grade 0.75 0.75 0.8)
0.765
> 
>Problem 2
>
> (grade 0.75 0.75 0.8)
0.765
> (grade 0.95 0.75 0.8)
0.835
> (grade 0.4 0.85 0.9)
0.7075
> (grade 0 0 0)
0
> (grade 1.5 1 1)
1.175
> (grade 1 1 1)
1.0
> (grade 0 2 1)
1.0
> (Grade 0 0 3)
0.9
> 
>Problem 3
>
>> (ladder-height 10 6)
8
> (ladder-height 13 5)
12
> (ladder-height 20 3.5)
19.691368667515217
> (ladder-height 10 10)
0
> (ladder-height .1 .06)
0.08000000000000002
> (ladder-height -1 -6)
0+5.916079783099616i
> 
>Problem 4
>
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
>Problem 5
>
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