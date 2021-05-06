#lang racket
(require "../libs/trs/mk.rkt")
(require "./anyo.rkt")
(provide (all-defined-out))

; 6.4
(define nevero (anyo fail))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-divergence "6.5"
                   (run 1 (q)
                        nevero 
                        (== #t q)))

  (test-divergence "6.6"
                   (run 1 (q)
                        fail ; short-circuiting all by fail
                        nevero))

  
  ;; outer's fail cause retry conde's 2nd line
  
  (test-divergence "6.16"
                   (run 1 (q)
                        (salo nevero)
                        fail
                        (== #t q)))

  (test-divergence "6.17"
                   (run 1 (q) 
                        alwayso 
                        fail
                        (== #t q)))

  )
