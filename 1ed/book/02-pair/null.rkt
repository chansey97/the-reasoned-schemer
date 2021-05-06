#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

;; 2.35
(define nullo
  (lambda (x)
    (== '() x)))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "2.30"
              (null? `(grape raisin pear))
              #f)

  (test-check "2.31"
              (null? '())
              #t)

  (test-check "2.32"
              (run* (q)
                    (nullo `(grape raisin pear))
                    (== #t q))
              `())

  (test-check "2.33"
              (run* (q)
                    (nullo '())
                    (== #t q))
              `(#t))

  (test-check "2.34"
              (run* (x) 
                    (nullo x))
              `(()))

  )

