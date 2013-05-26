#lang eopl
(#%require (only racket/base random))
(#%require (only racket/base gensym))

(define-datatype pair-adt pair?
  (pair (first  any?)
        (second any?)))

(define any?
  (lambda (x)
    #t))

(define-datatype binary-tree binary-tree?
  (leaf-node     (datum number?))
  (interior-node (key   symbol?) 
                 (left  binary-tree?)
                 (right binary-tree?)))

(define bintree-member? 
  (lambda (val tree)
    (cases binary-tree tree
      (leaf-node (datum)
                 (eq? val datum))
      (interior-node (key left right)
                     (or (bintree-member? val left)
                         (bintree-member? val right)))
      (else
       '(error "bintree-member?: Invalid tree" tree)))))

(define small-tree (leaf-node 0))
(define large-tree (interior-node 'foo
                                  (interior-node 'bar
                                                 (leaf-node 1)
                                                 (leaf-node 2))
                                  (leaf-node 3)))

(define max-leaf
  (lambda (tree)
    (cases binary-tree tree
      (leaf-node (datum) datum)
      (interior-node (key left right)
        (max (max-leaf left) (max-leaf right)))
      )))

(define random-tree
  (lambda (n)
    (if (< (random 100) n)             
        (leaf-node (random 1000))
        (interior-node (gensym)
                       (random-tree n)
                       (random-tree n)))))

(define bst->list
   (lambda (tree)
      (cases binary-tree tree
         (leaf-node (datum)
            datum)
         (interior-node (key left-subtree right-subtree)
            (list key
                  (bst->list left-subtree)
                  (bst->list right-subtree)))) ))