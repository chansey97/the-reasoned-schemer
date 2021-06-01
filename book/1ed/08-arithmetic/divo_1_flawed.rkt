#lang racket
(require "../libs/trs/mk.rkt")
(require "../07-arithmetic/pluso.rkt")
(require "./mulo_2_correct.rkt")
(require "./length-comparison/ltelo_2_correct.rkt")
(require "./comparison/lto.rkt")
(provide (all-defined-out))

; 8.63
(define /o
  (lambda (n m q r)
    (condi
     ((== '() q) (== n r) (<o n m))
     ((== '(1) q) (== '() r) (== n m)
                  (<o r m))      
     ((<o m n) (<o r m)
               (fresh (mq)
                      (<=lo mq n)
                      (*o m q mq)
                      (+o mq r n)))
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-divergence "8.81"
                   (run 3 (t)
                        (fresh (y z)
                               (/o `(1 0 . ,y) '(0 1) z '())
                               (== `(,y ,z) t))))
  )

