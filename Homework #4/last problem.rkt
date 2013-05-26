Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
> (positions-of 'a '(a b a c d a e f g a h i j k))
(0 2 5 9)
> (positions-of 'a '(b c d e f g h i j k))
()
> (= (count 'a '(a b a c d a e))
          (length (positions-of 'a '(a b a c d a e))))
#t
> 