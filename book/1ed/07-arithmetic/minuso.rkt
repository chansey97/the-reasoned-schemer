#lang racket
(require "../libs/trs/mk.rkt")
(require "./pluso.rkt")
(provide (all-defined-out))

; 7.130
(define -o
  (lambda (n m k)
    (+o m k n)))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "7.131"
              (run* (q)
                    (-o '(0 0 0 1) '(1 0 1) q))
              `((1 1)))

  (test-check "7.132"
              (run* (q)
                    (-o '(0 1 1) '(0 1 1) q))
              `(()))

  (test-check "7.133"
              (run* (q)
                    (-o '(0 1 1) '(0 0 0 1) q))
              `())

  )
