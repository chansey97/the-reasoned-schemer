#lang racket
(require "./libs/minikanren/minikanren.rkt")
(provide (all-defined-out))

(define succeed (== #t #t))
(define fail (== #t #f))
(define else succeed)
