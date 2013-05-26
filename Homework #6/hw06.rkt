;;
;; FILE:     homework06.rkt
;; AUTHOR:   Taylor Brown
;; DATE:     02/27/13
;; COMMENT:  Further practice writing recursive procedures
;;           
;;
;; MODIFIED: none yet
;; CHANGE:   none yet
;;
(define zip
  (lambda (lst1 lst2)
    (if (null? lst1)
        '()
        (cons (list (car lst1) (car lst2))
              (zip (cdr lst1) (cdr lst2))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tails
  (lambda (lst)
    (if (null? lst)
        (list '())
        (cons lst
              (tails (cdr lst))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define swap
  (lambda (var1 var2 s-list)
    (if (null? s-list)
        '()
        (cons (swap-symexp var1 var2 (car s-list))
              (swap var1 var2 (cdr s-list))))))

(define swap-symexp
  (lambda (var1 var2 symexp)
    (if (symbol? symexp)
        (cond
          ((eq? symexp var1) var2)
          ((eq? symexp var2) var1)
          (else symexp))
        (swap var1 var2 symexp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define uniq-c
  (lambda (s-list)
    (uniq-c-helper (uniq s-list) s-list)))

(define uniq-c-helper
  (lambda (uniq-s-list s-list)
    (if (null? uniq-s-list)
        '()
        (cons (list (car uniq-s-list) (count-symbol-slst (car uniq-s-list) s-list))
              (uniq-c-helper (cdr uniq-s-list) s-list)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define bst?
  (lambda (bin-tree)
    (if (number? bin-tree)
        #t
        (and (bst->left-less-than-node?  (bst->node bin-tree) (bst->left-subtree bin-tree))
             (bst->right-less-than-node? (bst->node bin-tree) (bst->right-subtree bin-tree))
             (bst? (bst->left-subtree bin-tree))
             (bst? (bst->right-subtree bin-tree))))))

(define bst->subtree-test?
  (lambda (node test bin-tree)
    (if (number? bin-tree)
        bin-tree
        (and (test node (bst->subtree-test? node test (car bin-tree)))
             (if (null? (cdr bin-tree))
                 (car bin-tree)
                 (bst->subtree-test? node test (cdr bin-tree)))))))

(define bst->left-less-than-node?
  (lambda (node bin-tree)
    (if (number? bin-tree)
        (> node bin-tree)
        (bst->subtree-test? node > bin-tree))))

(define bst->right-less-than-node?
  (lambda (node bin-tree)
    (if (number? bin-tree)
        (< node bin-tree)
        (bst->subtree-test? node < bin-tree))))

(define bst->node
  (lambda (bin-tree)
    (car bin-tree)))
(define bst->left-subtree
  (lambda (bin-tree)
    (car (cdr bin-tree))))
(define bst->right-subtree
  (lambda (bin-tree)
    (car (cdr (cdr bin-tree)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define count-symbol-slst;;;;;;;;;could make drastic changes to this to eliminate duplication. THE QUESTION YOU ASKED WALLINGFORD!!!!
  (lambda (symbol s-list)
    (if (null? s-list)
        0
        (+ (count-symbol-slst-symexp symbol (car s-list))
           (count-symbol-slst symbol (cdr s-list))))))
(define count-symbol-slst-symexp
  (lambda (symbol symexp)
    (if (symbol? symexp)
        (cond 
          ((eq? symexp symbol) 1)
          (else 0))
        (count-symbol-slst symbol symexp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Re-used procedures                                                      ;
(define uniq                                                             ;
  (lambda (slst)                                                         ;
    (uniq-aps slst '())))                                                ;
                                                                         ;
(define uniq-aps                                                         ;
  (lambda (slst symbols-no-repeats)                                      ;
    (if (null? slst)                                                     ;
        symbols-no-repeats                                               ;
        (uniq-aps (cdr slst)                                             ;
                  (uniq-aps-symexp (car slst) symbols-no-repeats)))))    ;
                                                                         ;
(define uniq-aps-symexp                                                  ;
  (lambda (symexp symbols-no-repeats)                                    ;
    (if (symbol? symexp)                                                 ;
        (if (in? symexp symbols-no-repeats)                              ;
            symbols-no-repeats                                           ;
            (cons symexp symbols-no-repeats))                            ;
        (uniq-aps symexp symbols-no-repeats))))                          ;
                                                                         ;
(define in?                                                              ;
  (lambda (to-compare lst)                                               ;
    (if (null? lst)                                                      ;
        #f                                                               ;
        (or (in?-symexp to-compare (car lst))                            ;
             (in? to-compare (cdr lst))))))                              ;
                                                                         ;
(define in?-symexp                                                       ;
  (lambda (to-compare symexp)                                            ;
    (if (symbol? symexp)                                                 ;
        (eq? symexp to-compare)                                          ;
        (in? to-compare symexp))))                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
