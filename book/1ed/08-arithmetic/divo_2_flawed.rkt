#lang racket
(require "../libs/trs/mk.rkt")
(require "../07-arithmetic/pluso.rkt")
(require "./mulo_2_correct.rkt")
(require "./length-comparison/ltelo_2_correct.rkt")
(require "./comparison/lto.rkt")
(provide (all-defined-out))

; 8.74.1
(define /o
  (lambda (n m q r)
    (fresh (mq)
           (<o r m)
           (<=lo mq n)
           (*o m q mq)
           (+o mq r n))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-divergence "8.74.2"
                   (run* (m)
                         (fresh (r)
                                (/o '(1 0 1) m () '(1 1 1) r))))

  )
