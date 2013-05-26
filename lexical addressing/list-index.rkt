;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   list-index.rkt                                    |
;; |   AUTHOR         :   Eugene Wallingford                                |
;; |   CREATION DATE  :   March 4, 2004                                     |
;; |                                                                        |
;; |   DESCRIPTION    :   list-index returns the 0-based position of        |
;; |                      an item in a list, or -1 if not found.            |
;; |                      (We saw this procedure in Session 15.)            |
;; |                                                                        |
;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   MODIFIED BY    :                                                     |
;; |   DATE           :                                                     |
;; |   DESCRIPTION    :                                                     |
;; |                                                                        |
;;  ------------------------------------------------------------------------

(define list-index
  (lambda (target los)
    (list-index-helper target los 0)))

;;  ------------------------------------------------------------------------

(define list-index-helper
  (lambda (target los base)
    (if (null? los)
        -1
        (if (eq? target (car los))
            base
            (list-index-helper target (cdr los) (+ base 1))))))

;; ----- END OF FILE -------------------------------------------------------