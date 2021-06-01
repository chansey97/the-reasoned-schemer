#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 10.19.1
(define onceo
  (lambda (g)
    (condu
     (g succeed)
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  (require (file "../06-infinite-&-divergence/nevero.rkt"))
  (require (file "../06-infinite-&-divergence/salo.rkt"))
  
  ; 1.56
  (define teacupo
    (lambda (x)
      (conde
       ((== 'tea x) succeed)
       ((== 'cup x) succeed)
       (else fail))))
  
  (test-check "10.19.2"
              (run* (x)
                    (onceo (teacupo x)))
              `(tea))

  (test-check "10.20"
              (run 1 (q)
                   (onceo (salo nevero))
                   fail)
              `())

  )
