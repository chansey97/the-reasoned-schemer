#lang racket
(require "../1-substitution/empty-s.rkt")
(require "../3-stream/take-inf.rkt")
(provide (all-defined-out))

;; 10.115
(define (run-goal n g)
  (take-inf n (g empty-s)))
