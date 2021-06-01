#lang racket
(require "../../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.5
(define bit-xoro
  (lambda (x y r)
    (conde
     ((== 0 x) (== 0 y) (== 0 r))
     ((== 1 x) (== 0 y) (== 1 r))
     ((== 0 x) (== 1 y) (== 1 r))
     ((== 1 x) (== 1 y) (== 0 r))
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "7.6"
              (run* (s)
                    (fresh (x y)
                           (bit-xoro x y 0)
                           (== `(,x ,y) s)))  
              `((0 0)
                (1 1)))

  (test-check "7.8"
              (run* (s)
                    (fresh (x y)
                           (bit-xoro x y 1)
                           (== `(,x ,y) s)))
              `((1 0)
                (0 1)))

  (test-check "7.9"
              (run* (s)
                    (fresh (x y r)
                           (bit-xoro x y r)
                           (== `(,x ,y ,r) s)))
              `((0 0 0) 
                (1 0 1)
                (0 1 1)
                (1 1 0)))

  )
