#lang racket
(require "../1-substitution/unify.rkt")
(provide (all-defined-out))

;; 10.43
(define (== u v)
  (lambda (s)
    (let ((s (unify u v s)))
      (if s `(,s) '()))))
