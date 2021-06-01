#lang racket
(require "../1-substitution/empty-s.rkt")
(require "./reify-s.rkt")
(require "./walk_star.rkt")
(provide (all-defined-out))

;; 10.111
(define (reify v)
  (lambda (s)
    (let ((v (walk* v s)))
      (let ((r (reify-s v empty-s)))
        (walk* v r)))))
