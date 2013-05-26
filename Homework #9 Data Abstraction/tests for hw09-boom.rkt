;;; -----------------------------------------------------------
;;; -----------------------------------------------------------
;;; -----------------------------------------------------------
'Problem1
'(define address (record 'city 'state 'zipcode))
(define address (record 'city 'state 'zipcode))
'(record-get address 'city)
(list (record-get address 'city) '=> '**xx**)
'(define address2 (record-put address2 'city "Cedar Falls"))
(define address2 (record-put address 'city "Cedar Falls"))
'(record-get address2 'city)
(list (record-get address2 'city) '=> "Cedar Falls")
'-------------------------------------------------------
'Problem2
'(define small-tree (leaf-node 0))
(define small-tree (leaf-node 0))
'(define large-tree (interior-node 'foo
                                   (interior-node 'bar
                                                  (leaf-node 1)
                                                  (leaf-node 2))
                                   (leaf-node 3)))
'(define large-tree (interior-node 'foo
                                        (interior-node 'bar
                                                       (leaf-node 1)
                                                       (leaf-node 2))
                                        (leaf-node 3)))
(define larger-tree (interior-node 'rasp
                                   (interior-node 'lasp
                                                  (interior-node 'clasp
                                                                 (leaf-node 1)
                                                                 (leaf-node 2))
                                                  (interior-node 'sasp
                                                                 (leaf-node 3)
                                                                 (leaf-node 4)))
                                   (interior-node 'zasp
                                                  (interior-node 'grasp
                                                                 (leaf-node 5)
                                                                 (leaf-node 6))
                                                  (interior-node '...
                                                                 (leaf-node 7)
                                                                 (leaf-node 8))) ))                             
'(bintree-member? 3 small-tree) 
(list (bintree-member? 3 small-tree) '=> #f)
'(bintree-member? 3 large-tree)
(list (bintree-member? 3 large-tree) '=> #t)
'(bintree-member? 9 larger-tree)
(list (bintree-member? 9 larger-tree) '=> #f)
'(bintree-member? 8 larger-tree)
(list (bintree-member? 8 larger-tree) '=> #t)
'-------------------------------------------------------
'Problem3
'(run-length-encode '(1 1 1 1 2))
(list (run-length-encode '(1 1 1 1 2)) '=> '((1 . 4) 2))
'(run-length-encode '(o o o o o o o p p s))
(list (run-length-encode '(o o o o o o o p p s)) '=> '((o . 7) (p . 2) s ))
'(run-length-encode '(1 2 2 3 3 3 4 4 4 4 5 5 5 6 6 7))
(list (run-length-encode '(1 2 2 3 3 3 4 4 4 4 5 5 5 6 6 7)) '=> '(1 (2 . 2) (3 . 3) (4 . 4) (5 . 3) (6 . 2) 7))
(define binary-file
  '(0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 1
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1
     1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
'(run-length-encode binary-file)
(list (run-length-encode binary-file) '=> '((0 . 10) (1 . 12) (0 . 6) 1 (0 . 23) (1 . 17) (0 . 15)))
'(define diff-binary-file
  (0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1))
(define diff-binary-file
  '(0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1))
'(run-length-encode diff-binary-file)
(list (run-length-encode diff-binary-file) '=> '((0 . 2) (1 . 2) (0 . 2) (1 . 2) (0 . 2) (1 . 2) (0 . 2) (1 . 2) (0 . 2) (1 . 2)))
'-------------------------------------------------------
'Problem4
'(define boom-equation '(4 + 5))
(define boom-equation '(4 + 5))
'(boom/equation->left-exp boom-equation)
(list (boom/equation->left-exp boom-equation) '=> 4)
'(boom/equation->right-exp boom-equation)
(list (boom/equation->right-exp boom-equation) '=> 5)
'(boom/equation->operator boom-equation)
(list (boom/equation->operator boom-equation) '=> '+)
'(boom/equation? boom-equation)
(list (boom/equation? boom-equation) '=> #t)
'(boom/operator? '*)
(list (boom/operator? '*) '=> #t)
'(boom/operator '%)
(list (boom/operator '%) '=> '(modulo procedure:))
'(boom/exp? boom-equation)
(list (boom/exp? boom-equation) '=> #t)
'(boom/exp? 1)
(list (boom/exp? 1) '=> #t)
'(boom/exp? '*)
(list (boom/exp? '*) '=> #f)
'-------------------------------------------------------
'Problem5
'(boom/eval 2)
(list (boom/eval 2) '=> 2)
'(boom/eval '(2 + 4))
(list (boom/eval '(2 + 4)) '=> 6)
'(boom/eval '((2 * 14) + (4 - 6)))
(list (boom/eval '((2 * 14) + (4 - 6))) '=> 26)
'(boom/eval '((8 % 3) + (4 * (6 - (20 / 10)))))
(list (boom/eval '((8 % 3) + (4 * (6 - (20 / 10))))) '=> 18)
'(boom/eval '(8 & 3))
(list (boom/eval '(8 & 3)) '=> 'ERROR)

