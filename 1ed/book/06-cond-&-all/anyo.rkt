#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 6.1
(define anyo
  (lambda (g)
    (conde
     (g succeed)
     (else (anyo g)))))

