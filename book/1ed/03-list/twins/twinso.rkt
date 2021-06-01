#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_1-pair/conso.rkt")
(provide (all-defined-out))

; 3.31
(define twinso
  (lambda (s)
    (fresh (x y)
           (conso x y s)
           (conso x '() y))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "3.32"
              (run* (q)
                    (twinso '(tofu tofu))
                    (== #t q))
              (list #t))

  (test-check "3.33"
              (run* (z) 
                    (twinso `(,z tofu)))
              (list `tofu))
  )
