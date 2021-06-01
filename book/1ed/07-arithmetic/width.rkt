#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.104.2

(define width
  (lambda (n)
    (cond
      ((null? n) 0)
      ((pair? n)(+ (width (cdr n)) 1))
      (else 1))))
