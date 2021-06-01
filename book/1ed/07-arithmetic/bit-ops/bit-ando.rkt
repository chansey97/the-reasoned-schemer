#lang racket
(require "../../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.10
(define bit-ando
  (lambda (x y r)
    (conde
     ((== 0 x) (== 0 y) (== 0 r))
     ((== 1 x) (== 0 y) (== 0 r))
     ((== 0 x) (== 1 y) (== 0 r))
     ((== 1 x) (== 1 y) (== 1 r))
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "7.11"
              (run* (s)
                    (fresh (x y)
                           (bit-ando x y 1)
                           (== `(,x ,y) s)))  
              `((1 1)))
  )

