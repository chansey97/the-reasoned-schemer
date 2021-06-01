#lang racket
(require "../1-substitution/var.rkt")
(provide (all-defined-out))

;; 10.90
(define (call/fresh name f)
  (f (var name)))
