#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

;; 2.40
(define eqo
  (lambda (x y)
    (== x y)))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "2.36"
              (eq? 'pear 'plum)
              #f)

  (test-check "2.37"
              (eq? 'plum 'plum)
              #t)
  
  (test-check "2.38"
              (run* (q)
                    (eqo 'pear 'plum)
                    (== #t q))
              `())

  (test-check "2.39"
              (run* (q)
                    (eqo 'plum 'plum)
                    (== #t q))
              `(#t))

  (test-check "2.43"
              (pair? `((split) . pea))
              #t)

  (test-check "2.44"
              (pair? '())
              #f)

  (test-check "2.48"
              (car `(pear))
              `pear)

  (test-check "2.49"
              (cdr `(pear))
              `())

  (test-check "2.51"
              (cons `(split) 'pea)
              `((split) . pea))

  (test-check "2.52"
              (run* (r) 
                    (fresh (x y)
                           (== (cons x (cons y 'salad)) r)))
              (list `(_.0 _.1 . salad)))
  )
