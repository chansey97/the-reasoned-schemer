#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

;; all has no value
(test-divergence "6.31"
  (run 1 (q)                                                                  
    (all
      (conde
        ((== #f q) succeed)
        (else (== #t q)))                    
      alwayso)
    (== #t q)))

;; alli has values
(test-check "6.32"
  (run 1 (q)                                                                  
    (alli
      (conde
        ((== #f q) succeed)
        (else (== #t q)))                    
      alwayso)                                                        
    (== #t q))
  `(#t))

(test-check "6.33"
  (run 5 (q)
    (alli
      (conde
        ((== #f q) succeed)
        (else (== #t q)))                    
      alwayso)                                                        
    (== #t q))
  `(#t #t #t #t #t))

;; swap two conde lines
(test-check "6.34"
  (run 5 (q)
    (alli
      (conde
        ((== #t q) succeed)
        (else (== #f q)))
      alwayso)                                           
    (== #t q))
  `(#t #t #t #t #t))

;; all has values
(test-check "6.36"
  (run 5 (q)
    (all
      (conde
        (succeed succeed)
        (else nevero))
      alwayso)
    (== #t q))
  `(#t #t #t #t #t))

;; alli has no value
(test-divergence "6.37"
  (run 5 (q)
    (alli
      (conde
        (succeed succeed)
        (else nevero))
      alwayso)
    (== #t q)))

(test-divergence "6.38"
  (run 5 (q)
    (alli
      (conde
        (succeed succeed)
        (else nevero))
      alwayso)
    (== #t q)))

;; (run 2 (q)
;;     (alli
;;       (conde
;;         (succeed succeed)
;;         (else nevero))
;;       alwayso)
;;     (== #t q))
