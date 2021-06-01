#lang racket
(require "../../libs/trs/mk.rkt")
(require "./membero.rkt")
(provide (all-defined-out))

; 3.95
(define first-value
  (lambda (l)
    (run 1 (y)
         (membero y l))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "3.96"
              (first-value `(pasta e fagioli))
              `(pasta))

  (test-check "3.97"
              (first-value `(pasta e fagioli))
              (list `pasta))
  )
