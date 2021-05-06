#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

;; condi has values
(test-check "6.25"
  (run 5 (q)
    (condi
      ((== #f q) alwayso)
      ((== #t q) alwayso)
      (else fail))
    (== #t q))
  `(#t #t #t #t #t))

;; conde has no value
(test-divergence "6.27"
  (run 5 (q)
    (conde
      ((== #f q) alwayso)
      ((== #t q) alwayso)
      (else fail))
    (== #t q)))

;; conde has values
(test-check "6.28"
  (run 5 (q)                                                                  
    (conde                                                                     
      (alwayso succeed)
      (else nevero))
    (== #t q))
  `(#t #t #t #t #t))

;; condi has no value
(test-divergence "6.30"
  (run 5 (q)                                                                  
    (condi                                                                 
      (alwayso succeed)
      (else nevero))
    (== #t q)))
