#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(provide (all-defined-out))

; 5.38
(define swappendo
  (lambda (l s out)
    (conde
     (succeed
      (fresh (a d res)
             (conso a d l)
             (conso a res out)
             (swappendo d s res)))
     (else (nullo l) (== s out)))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-divergence "5.39"
                   (run 1 (z)
                        (fresh (x y)
                               (swappendo x y z))))

  (require "../../libs/trs/mkextraforms.rkt")
  
  
  )
