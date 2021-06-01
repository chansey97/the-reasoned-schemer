#lang racket
(require "../../libs/trs/mk.rkt")
(provide (all-defined-out))

; Another way to define twinso, without using conso

; 3.36
(define twinso
  (lambda (s)
    (fresh (x)
           (== `(,x ,x) s))))
