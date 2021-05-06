#lang racket
(require "../libs/trs/mk.rkt")
(require "./addero.rkt")
(provide (all-defined-out))

; 7.128
(define +o
  (lambda (n m k)
    (addero 0 n m k)))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "7.129"
              (run* (s)
                    (fresh (x y)
                           (+o x y '(1 0 1))
                           (== `(,x ,y) s)))
              `(((1 0 1) ())
                (() (1 0 1))
                ((1) (0 0 1))
                ((0 0 1) (1))
                ((1 1) (0 1))
                ((0 1) (1 1))))
  )
