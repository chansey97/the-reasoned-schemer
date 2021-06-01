#lang racket
(provide (all-defined-out))

(define succeed
  (lambda (s)
    `(,s)))

(define fail
  (lambda (s)
    '()))
