#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(provide (all-defined-out))

;; swappendo just appendo with its two conde lines swapped, then divergence!

;; The reason is that there is no "The Law of Swapping conde Lines" in TRS1.
;; It is no problem in TRS2.

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


  
  )
