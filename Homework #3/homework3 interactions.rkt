Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
>
>Problem 1
>
> (softmax 3 4)
4.313261687518223
> (softmax 10 6)
10.01814992791781
> (softmax 25 64)
64.0
> (softmax 0 0)
0.6931471805599453
> (softmax -3 4)
4.000911466453775
>
> Problem 2
>
> (sum-of-apps square 3 4)
25
> (sum-of-apps cube 3 4)
91
> (sum-of-apps sqrt 25 64)
13
> (sum-of-apps square 0 0)
0
> (sum-of-apps square -4 -3)
25
> (sum-of-apps cube -3 4)
37
>
>Problem 3
>
> ((candy-temperature-of 302) 5280)
291.44
> (define temp-for-fudge
         (candy-temperature-of 240))
> (temp-for-fudge 959)
238.082
> ((candy-temperature-of 10) 5500)
-1.0
> ((candy-temperature-of 250) 0)
250
> ((candy-temperature-of 302) -1400)
304.8
>
>Problem 4
>
> ((in-range-of? 0.1) 4.95 5.0)
#t
> ((in-range-of? 0.1) 5.0 4.95)
#t
> (define within-0.01?
          (in-range-of? 0.01))
> (within-0.01? 4.95 5.0) 
#f
> (within-0.01? 5.0 4.99)
#t
> (define within-0.00?
    (in-range-of? 0.00))
> (within-0.00? 5.0 5.0)
#t
> ((in-range-of? 1.00) .5 -.5)
#t
>
>Problem 5
>
> (softmax-var 3 4 10 6)
10.021474046393745
> (softmax-var 25 64 100)
100.0
> (softmax-var 42)
42.0
> (apply softmax-var (sequence 1 709))
709.4586751453871
> (softmax-var 0)
0
> (apply softmax-var (sequence 0 500))
500.4586751453871
>
>BONUS
>
> ((sum-of cube) 3  4)
91
> ((sum-of sqrt) 1 4 9 16 25 36 49 64)
36
> (define sum-of-squares (sum-of square))
> (sqrt (sum-of-squares 5 12))
13
> (sum-of-squares 1 12 36 60)
5041
> (sum-of-squares 1 3 5 7 9 11 13 15)
680
> (sum-of-squares 10)
100
> (apply sum-of-squares (sequence 1 100))
338350
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