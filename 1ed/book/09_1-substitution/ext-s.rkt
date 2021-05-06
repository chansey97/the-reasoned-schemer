#lang racket
(provide (all-defined-out))

(define ext-s
  (lambda (x v s)
    (cons `(,x . ,v) s)))

(module+ main
  (require "../libs/test-harness.rkt")
  (require "./var.rkt")
  (require "./walk.rkt")
  
  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  (test-divergence "9.29"
                   (walk x (ext-s x y `((,z . ,x) (,y . ,z)))))

  (test-check "9.30"
              (walk y `((,x . e)))
              y)

  (test-check "9.31"
              (walk y (ext-s y x `((,x . e))))
              'e)

  (test-check "9.32"
              (walk x `((,y . ,z) (,x . ,y)))
              z)

  (test-check "9.33"
              (walk x (ext-s z 'b `((,y . ,z) (,x . ,y))))
              'b)

  (test-check "9.34"
              (walk x (ext-s z w `((,y . ,z) (,x . ,y))))
              w)
  )
