#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/cons.rkt")
(provide (all-defined-out))

; 3.51.2
(define eq-car?
  (lambda (l x)
    (eq? (car l) x)))

; 3.54.1
(define eq-caro
  (lambda (l x)
    (caro l x)))
