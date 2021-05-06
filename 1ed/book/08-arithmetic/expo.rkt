#lang racket
(require "../libs/trs/mk.rkt")
(require "logo.rkt")
(provide (all-defined-out))

; 8.91
(define expo
  (lambda (b q n)
    (logo n b q '())))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "8.92"
              (run* (t)
                    (expo '(1 1) '(1 0 1) t))
              (list `(1 1 0 0 1 1 1 1)))
  )
