#lang racket
(require "../libs/trs/mk.rkt")
(require "./bumpo.rkt")
(require (file "./gen&testo.rkt"))
(provide (all-defined-out))

; 10.43.1
(define enumerateo
  (lambda (op r n)
    (fresh (i j k)
           (bumpo n i)
           (bumpo n j)
           (op i j k)
           (gen&testo op i j k)
           (== `(,i ,j ,k) r))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  (require "../07-arithmetic/pluso.rkt")
  
  (test-check "10.43.2"
              (run* (s)
                    (enumerateo +o s '(1 1)))
              `(((1 1) (1 1) (0 1 1))
                ((1 1) (0 1) (1 0 1))
                ((1 1) (1) (0 0 1))
                ((1 1) () (1 1))
                ((0 1) (1 1) (1 0 1))
                ((0 1) (0 1) (0 0 1))
                ((0 1) (1) (1 1))
                ((0 1) () (0 1))
                ((1) (1 1) (0 0 1))
                ((1) (0 1) (1 1))
                ((1) (1) (0 1))
                ((1) () (1))
                (() (1 1) (1 1))
                (() (0 1) (0 1))
                (() (1) (1))
                (() () ())))

  (test-check "10.56"
              (run 1 (s)
                   (enumerateo +o s '(1 1 1)))
              `(((1 1 1) (1 1 1) (0 1 1 1))))

  )

