#lang racket
(require "../../libs/trs/mk.rkt")
(require "./lto.rkt")
(provide (all-defined-out))

; 8.46.2
(define <=o
  (lambda (n m)
    (condi
     ((== n m) succeed)
     ((<o n m) succeed)
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "8.49.2"
              (run* (q)
                    (<=o '(1 0 1) '(1 0 1))
                    (== #t q))
              `(#t))
  )
