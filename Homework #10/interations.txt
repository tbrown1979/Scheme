Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
Problems1-3
(int->bignum 0)
(0)
(int->bignum 16)
(6 1)
(int->bignum 4256)
(6 5 2 4)
(int->bignum 262144)
(4 4 1 2 6 2)
(bignum->int '(0))
0
(bignum->int '(6 1))
16
(bignum->int '(6 5 2 4))
4256
(bignum->int '(4 4 1 2 6 2))
262144
----------
(big+ (int->bignum 321) (int->bignum 321))
(2 4 6)
(big+ (int->bignum 15) (int->bignum 257))
(2 7 2)
(big+ (int->bignum 4191) (int->bignum 65))
(6 5 2 4)
(define big4191 (int->bignum 4191))
(define big65 (int->bignum 65))
(bignum->int (big+ big4191 big65))
4256
(big+ (int->bignum 81) (int->bignum 51))
(2 3 1)
(define six-nines (int->bignum 999999))
(bignum->int (big+ six-nines six-nines))
1999998
(big+ (int->bignum 4991) (int->bignum 65))
(6 5 0 5)
(bignum->int (big+ (int->bignum 4991) (int->bignum 65)))
5056
boom-language
--------------------------------------------------------
Problems4-5
--------------------------------------------------------
(boom/eval '(- 3))
-3
(boom/eval '(- (- 9)))
9
(boom/eval '(sqrt 9))
3
(boom/eval '((- 3) + (sqrt (4 * 16))))
5
(boom/eval '(((130 - 2) / 4) % (15 / (17 % (sqrt 36)))))
2
(boom/preprocess '(3 @ 9))
((3 + 9) / 2)
(boom/preprocess '(- (3 @ 9)))
(- ((3 + 9) / 2))
(boom/preprocess '((2 * 14) + (13 @ 29)))
((2 * 14) + ((13 + 29) / 2))
(boom/eval (boom/preprocess '(3 @ 9)))
6
(boom/eval (boom/preprocess '((2 * 14) + (13 @ 29))))
49
(boom/preprocess '((13 @ (4 + 5)) @ ((2 + 2) @ (4 % 2))))
(((13 @ (4 + 5)) + ((2 + 2) @ (4 % 2))) / 2)
(boom/preprocess '((13 @ (4 + 5)) @ ((2 + 2) @ (4 % 2))))
((((13 + (4 + 5)) / 2) + (((2 + 2) + (4 % 2)) / 2)) / 2)
(boom/eval (boom/preprocess '((13 @ (4 + 5)) @ ((2 + 2) @ (4 % 2)))))
6