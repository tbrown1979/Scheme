Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
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