#lang racket
(provide (all-defined-out))

(define-syntax var
  (syntax-rules ()
    ((var w) (vector w))))

(define-syntax var?
  (syntax-rules ()
    ((var? w) (vector? w))))
