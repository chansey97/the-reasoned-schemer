#lang racket
(require "./append-inf.rkt")
(require "./append-map-inf.rkt")
(provide (all-defined-out))

;; 10.81
(define (conj2 g1 g2)
  (lambda (s)
    (append-map-inf g2 (g1 s))))
