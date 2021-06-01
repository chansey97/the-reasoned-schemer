#lang racket
(provide (all-defined-out))

;; 10.4
(define var (lambda (x) (vector x)))
(define var? (lambda (x) (vector? x)))
