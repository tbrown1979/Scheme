Welcome to DrRacket, version 5.3.1 [3m].
Language: R5RS; memory limit: 128 MB.
problem1
(zip '(a b c) '(1 2 3))
((a 1) (b 2) (c 3))
-----
(zip '() '())
()
-----
problem2
(tails '(a b c d e f g))
((a b c d e f g) (b c d e f g) (c d e f g) (d e f g) (e f g) (f g) (g) ())
-----
(tails '((a b) (c d)))
(((a b) (c d)) ((c d)) ())
-----
(tails '())
(())
-----
problem3
(swap 'a 'b '((a b) (((b g r) (f r)) c (d e)) b))
((b a) (((a g r) (f r)) c (d e)) a)
-----
(swap 'a 'b '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
((b b) (((b (b) (b b)) (b (aaaa))) b (b b)) b)
-----
(swap 'x 'b '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a)
-----
problem4
(uniq-c '((a b) (((b g r) (f r)) c (d e)) b))
((e 1) (d 1) (c 1) (f 1) (r 2) (g 1) (b 3) (a 1))
-----
(uniq-c '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
((aaaa 1) (a 11))
-----
(uniq-c '((x x ((((x)))) xx)))
((xx 1) (x 3))
-----
(uniq-c '((((((((((x)))))))))))
((x 1))
-----
(uniq-c '(x x x x x))
((x 5))
-----
problem5
(bst? '(8 (3 1 5) (15 12 20)))
#t
-----
(bst? '(8 (3 1 12) (15 5 20)))
#f
-----
(bst? '(8 (1 3 12) (15 12 20)))
#f
-----
(bst? '(8 (3 1 (5 4 6)) (15 (12 10 14) 20)))
#t
-----
(bst? '(8 1 9))
#t
-----
(bst? '(8 (3 (1 0 2) (5 4 6)) (15 (12 10 14) (20 16 21))))
#t
-----
(bst? '(8 8 8))
#f
> 