#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "../libs/test-harness.rkt")
(require (file "../06-cond-&-all/alwayso.rkt"))

;; The Law of condu
;; condu behaves like conda, except that a successful question succeeds only once

(test-divergence "10.13"
  (run* (q)
    (conda
      (alwayso succeed)
      (else fail))
    (== #t q)))

(test-check "10.14"
  (run* (q)
    (condu
      (alwayso succeed)
      (else fail))
    (== #t q))
  `(#t))

(test-divergence "10.15"
  (run* (q)
    (condu
      (succeed alwayso)
      (else fail))
    (== #t q)))

(test-divergence "10.17"
  (run 1 (q)
    (conda
      (alwayso succeed)
      (else fail)) 
    fail
    (== #t q)))

(test-check "10.18"
  (run 1 (q)
    (condu
      (alwayso succeed)
      (else fail)) 
    fail
    (== #t q))
  `())
