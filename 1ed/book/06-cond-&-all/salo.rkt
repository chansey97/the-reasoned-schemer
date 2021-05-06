#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

;; salo stands for “succeeds at least once”.

; 6.12
(define salo
  (lambda (g)
    (conde
     (succeed succeed)
     (else g))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  (require "./alwayso.rkt")
  (require "./nevero.rkt")

  (test-check "6.13"
              (run 1 (q)
                   (salo alwayso)
                   (== #t q))
              `(#t))

  (test-check "6.14"
              (run 1 (q)
                   (salo nevero)
                   (== #t q))
              `(#t))

  (test-divergence "6.15"
                   (run* (q)
                         (salo nevero)
                         (== #t q)))

  
  )
