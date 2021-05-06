#lang racket
(require "../libs/trs/mk.rkt")
(require "./anyo.rkt")
(provide (all-defined-out))

;; 6.7
(define alwayso (anyo succeed))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "6.7"
              (run 1 (q) 
                   alwayso 
                   (== #t q))
              (list #t))

  (test-divergence "6.9"
                   (run* (q) 
                         alwayso 
                         (== #t q)))

  (test-check "6.10"
              (run 5 (q) 
                   alwayso 
                   (== #t q))
              `(#t #t #t #t #t))

  (test-check "6.11"
              (run 5 (q) 
                   (== #t q) 
                   alwayso)
              `(#t #t #t #t #t))

  )
